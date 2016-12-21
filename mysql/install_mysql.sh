#!/bin/bash

cd /usr/local
wget -c http://dev.mysql.com/get/Downloads/MySQL-5.5/mysql-5.5.54-linux2.6-x86_64.tar.gz
tar xvf mysql-5.5.54-linux2.6-x86_64.tar.gz 
mv mysql-5.5.54 mysql
cd mysql

# set auth

scripts/mysql_install_db --user=mysql

cp support-files/mysql.servier /etc/init.d/mysqld


service mysqld start|stop|restart|status|reload|...

# set root account of mysql
bin/mysqladmin -u root password ***

# set soft link for 'mysql'/'mysqladmin' command
ln -s bin/mysql /usr/bin
ln -s bin/mysqladmin /usr/mysqladmin

# grant an account of mysql named 'canonxu' with password 'foobar'

grant all privileges on *.* to canonxu@"%" identified by 'foobar' with grant option    # '%' representd all ip host

grant all privileges on *.* to canonxu@"localhost" identified by 'foobar' with grant option    # 'localhost' represents the local host, but connect through local scoket rather than ip, 

