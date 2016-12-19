#!/bin/bash

VERSION=$1

cd /usr/local
if [ -d /usr/local/protobuf ]; then
    rm -r /usr/local/protobuf
fi

# download protobuf package
URL=https://github.com/google/protobuf/releases/download/v$VERSION/protobuf-$VERSION.tar.gz
wget -c $URL 
if [ $? -ne 0 ]; then
    echo "fail to download, plz check..."
    exit 1
fi

# unpackage
tar xf protobuf-$VERSION.tar.gz
cd /usr/local
mv protobuf-$VERSION protobuf
cd protobuf

# make
./configure
make
make check
make install

# link
ldconfig

version=`protoc --version|cut -c 11:15`
if [ $version = $VERSION ]; then
    echo "protobuf $VERSION installed successfully"
else
    echo "something wrong with protobuf installing, plz check and re-install ..."
fi"
