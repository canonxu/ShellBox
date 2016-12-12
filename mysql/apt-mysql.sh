#/bin/bash

#Function: install MySql, default version is 5.5.47

install=$1

if [ $1 = "install" ]; then
    echo "start installing mysql..."
    apt-get install mysql-server mysql-client
    echo "install mysql successfully"
elif [ $1 = "uninstall" ]; then
    echo "start uninstalling mysql..."
    sudo apt-get remove mysql-server
    sudo apt-get remove mysql-client
    sudo apt-get remove mysql-common
    sudo apt-get autoremove mysql-common
    sudo apt-get remove mysql-community-server
    sudo apt-get autoremove mysql-community-server
    sudo apt-get remove mysql-community-client
    #clean configs
    dpkg -l|grrep ^rc|awk ‘{print $2}’|xargs dpkl --purge
    echo "uninstall mysql successfully"
fi

