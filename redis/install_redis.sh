#/bin/bash

#Function: install redis, default version is 3.2.6

version=3.2.6

path=~/redis
if [ ! -x $path ]; then
    echo "make directionary $path"
    mkdir $path
    cd $path
fi

source=http://download.redis.io/releases/redis-$version.tar.gz
wget -c $source
tar xvf redis-$version.tar.gz
cd redis-$version

echo "start make redis-$version..."
make
echo "install redis-$version successfully"
