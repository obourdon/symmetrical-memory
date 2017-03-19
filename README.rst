##################
symmetrical-memory
##################
Scripts for setting up and maintaining my home lab

=====
Usage
=====

getting this repository
-----------------------

Download this repository::

    sudo yum install -y git
    git clone https://github.com/hogepodge/symmetrical-memory.git

setup
-----

To get started, use the scripts in the `setup` directory to set up a
base CentOS 7 system. The first script updates your installation
and reboots (acquiring a new kernel if necessary). It also stops
and disables the firewall daemon.

The second script installs the base requirements, including the
Docker service. It configures a local registry, and downloads
and installs Kolla in a virtual environment.

The third script, to be run as root, builds a set of OpenStack
deployment containers for Kolla and loads them into the local
repository.

assumptions:

* You're running CentOS.
* The fixed IP address of the target host is 192.168.1.6.
* Registry storage is at a preconfigured directory named /registry.
* You want to run the registry on port 4000 rather than 5000, because Keystone.

docker
------

The docker directory contains a set of scrips to build and install
a small local standable Ironic service. Note that many assumptions
about my home lab are build into the container configuration, so
you will need to modify the files for your installation. Just run
the scripts in order. To tear down an installation, use the
`uninstall.sh` script.

This set of scripts assumes a CentOS 7 installation

===============
Acknowledgments
===============

This work leans heavily on the efforts of the OpenStack Bifrost team,
particularly the work and advice of Julia Kreger. Many thanks for her
support and patience as I learned to install and operate Ironic.

Also thanks to the OpenStack Kolla team for getting me started down
this path of using containers for operations.

Always a work in progress, and always being modified to fit my immediate
needs, I'm grateful to everyone for the support they've given to me, and
all mistakes are my own.