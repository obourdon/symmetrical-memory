#!/bin/bash -e

# begin by installing system dependencies
sudo yum install -y epel-release
sudo yum install -y git vim python-pip python-devel \
	libffi-devel gcc openssl-devel ansible ntp python-virtualenv \
	python-netaddr screen tmux net-tools bind-utils tcpdump wireshark nc telnet

# install and start ntp for system synchronization
sudo systemctl enable ntpd.service
sudo systemctl start ntpd.service

# Update pip to the latest version
sudo pip install -U pip 

# Install the docker engine from the docker repository
curl -sSL https://get.docker.io | bash

# Allow the local user to run and control docker
sudo usermod -aG docker $(id -nu)

# Set up Kolla specific configurations for docker
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo tee /etc/systemd/system/docker.service.d/kolla.conf <<-'EOF'
[Service]
MountFlags=shared
ExecStart=
ExecStart=/usr/bin/dockerd --insecure-registry 192.168.1.6:4000
EOF

# Reload docker to capture the system changes
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl enable docker

# Install python-docker-py
sudo yum install -y python-docker-py

# If it's running, stop and disable the libvirt service
set +e
sudo systemctl stop libvirtd.service
sudo systemctl disable libvirtd.service
set -e

# update pip and everything else
sudo pip install --upgrade pip virtualenv setuputils

# Prepare the virtualenv
mkdir -p kolla
cd kolla
virtualenv .kolla
source .kolla/bin/activate
pip install tox ansible

#Download and install kolla from source in a virtual environment
if [ ! -d kolla ]; then
	git clone https://github.com/openstack/kolla
fi
cd kolla
pip install --upgrade
pip install -r requirements.txt
pip install .
cd ..
if [ ! -d kolla-ansible ]; then
	git clone https://github.com/openstack/kolla-ansible
fi
cd kolla-ansible
pip install -r requirements.txt
pip install .
cd ..
sudo cp -r kolla-ansible/etc/kolla /etc/kolla/
cp kolla-ansible/ansible/inventory/* .

# download the ironic agent
mkdir -p config/ironic
curl -C - http://tarballs.openstack.org/ironic-python-agent/coreos/files/coreos_production_pxe.vmlinuz \
	-o config/ironic/ironic-agent.kernel -4
curl -C - http://tarballs.openstack.org/ironic-python-agent/coreos/files/coreos_production_pxe_image-oem.cpio.gz \
	-o config/ironic/ironic-agent.initramfs -4

# copy configuration
cp kolla-ansible/ansible/inventory/* .
#cp ~/symmetrical-memory/ironic/globals.yml globals.yml

# Install and start the docker registry
sudo docker run -d --name registry --restart=always -p 4000:5000 \
	-v /registry:/var/lib/registry registry:2 
