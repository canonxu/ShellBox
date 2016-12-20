#!/bin/bash

apt-get intall docker.io

version=`docker version|head -1|cut -c 8-` && echo "docker $version installed successfully"
