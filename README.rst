##################
symmetrical-memory
##################
Scripts for setting up and maintaining my home lab

=====
Usage
=====

Getting this Repository
-----------------------

Download this repository::

    sudo yum install -y git
    git clone https://github.com/hogepodge/symmetrical-memory.git

stage 1: setup 
--------------

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

Assumptions:

* You're running CentOS.
* The fixed IP address of the target host is 192.168.1.6.
* Registry storage is at a preconfigured directory named /registry.
* You want to run the registry on port 4000 rather than 5000, because Keystone.

stage 2: standalone ironic with docker
--------------------------------------

The docker directory contains a set of scrips to build and install
a small local standable Ironic service. Note that many assumptions
about my home lab are build into the container configuration, so
you will need to modify the files for your installation. Just run
the scripts in order. To tear down an installation, use the
`uninstall.sh` script.

This set of scripts assumes a CentOS 7 installation

===========
Limitations
===========

So many, just a few off the top of my head:

* In its current state, the application is heavily programmed for my
  working environment. I'm working on fixing this and making it a more
  generally useful system that works by configuration rather than
  magic variables in code. Sorry about that.
* I've only verified that this works with Ironic agent_ipmitool, rather
  than Ironic pxe_impitool. What's the difference? To over-simplify,
  iSCSI. I have not yet successfully booted an instance using the
  pxe_ipmitool (which uses iSCSI on the conductor to send images over)
  vs the agent_ipmitool (which pulls image data and writes it to disk).
  This is a work in progress that will sadly stay in progress for a
  while, as the agent_ipmitool get the job I need done, done.
* Security? What security? If you want this to be the base for a real
  operations tool, you have some work ahead of you. I believe that you
  can do it.

===============
Acknowledgments
===============

This work leans heavily on the efforts of the OpenStack Bifrost team,
particularly the work and advice of Julia Kreger. Many thanks for her
support and patience as I learned to install and operate Ironic.

Also thanks to the OpenStack Kolla team for getting me started down
this path of using containers for operations.

This will always be a work in progress, and I'll modify to fit
whatever my immediate needs are. I'm grateful to everyone for the
support they've given to me, and any mistakes I've made with this
project or bugs I've encoded are all my own.

If you find this useful, and want to help improve or maintain it,
I welcome any and all issues or pull requests.
