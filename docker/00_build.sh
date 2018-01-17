#!/bin/bash -e

docker build -t slab_dnsmasq dnsmasq/.
docker build -t slab_tftp tftp/.
docker build -t slab_imagedata imagedata/.
docker build -t slab_nginx nginx/.
docker build -t slab_ironic_base ironic_base/.
docker build -t slab_ironic_api ironic_api/.
docker build -t slab_ironic_conductor ironic_conductor/.
docker build -t slab_ironic_dbsync ironic_dbsync/.
docker build -t slab_test test/.
docker build -t slab_dib dib/.
