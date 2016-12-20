#/bin/bash

apt-get update
apt-get upgrade

sed -i 's/wheezy/jessie/g' /etc/apt/sources.list

apt-get update
apt-get upgrade
#(Y/I/N/O/D/Z)
apt-get dist-upgrade

# default linux kernel for debian 8 is 3.16
# remove linux kernel 3.2
apt-get remove linux-image-3.2.0-4-amd64
