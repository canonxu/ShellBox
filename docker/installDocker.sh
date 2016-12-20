#!/bin/bash

apt-get intall docker.io

version=`docker version|head -1|cut -c 8-` && echo "docker $version installed successfully"

# update to docker 1.9

sh -c "echo 'deb https://apt.dockerproject.org/repo debian-$(lsb_release -sc) main' | cat > /etc/apt/sources.list.d/docker.list"

apt-get purge docker.io
apt-get update
apt-get install docker-engine

version=`docker version|sed -n '2p'` && echo "docker $version installed successfully"
