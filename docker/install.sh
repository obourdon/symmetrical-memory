#!/bin/bash -e

./10_slab_rabbit.sh
./20_slab_mariadb.sh
./30_slab_imagedata.sh
./40_slab_tftp.sh
./50_slab_nginx.sh
./60_slab_dnsmasq.sh
./70_slab_ironic_dbsync.sh
./80_slab_ironic_api.sh
./90_slab_ironic_conductor.sh
