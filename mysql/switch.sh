#/bin/bash

# Function: start or stop or check status of mysql
# Tips: install the mysql-5.5 by binary tar.gz file cp mysql.server to /etc/init.d/mysqld

operation=$1

if [ $operation = "start" ]; then
    cd /usr/local/mysql
    bin/mysqld_safe --user=dba &
    echo "start successfully"
elif [ $operation = "stop" ]; then
    service mysqld stop
    echo "stop successfully"
elif [ $operation = "status" ]; then
    service mysqld status
    echo "check status successfully"
fi
