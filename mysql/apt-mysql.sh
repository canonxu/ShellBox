#/bin/bash

#Function: install MySql, default version is 5.5.47

install=$1

if [ $1 = "install" ]; then
    echo "start installing mysql..."
    apt-get install mysql-server
    echo "install mysql successfully"
elif [ $1 = "uninstall" ]; then
    echo "start uninstalling mysql..."
    sudo apt-get remove mysql-server
    echo "uninstall mysql successfully"
fi

