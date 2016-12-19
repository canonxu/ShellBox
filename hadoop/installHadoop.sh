#!/bin/bash

# Function: install hadoop

# Example: sudo bash installHadoop.sh

# install java-7
apt-get install openjdk-7-jdk
sed -i "$a export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" ~/.zshrc
source ~/.zshrc

# install maven
mvn --version
if [ $? -ne 0 ]; then
    echo "start install maven"
    apt-get install maven
    $version=`mvn --version|head -1`
    echo "$version installed successfully"
else
    $version=`mvn --version|head -1`
    echo "$version has been installed"
fi

# install cmake
cmake --version
if [ $? -ne 0 ]; then
    echo "start install cmake"
    apt-get install cmake
    $version=`cmake --version`
    echo "$version installed successfully"
else
    $version=`cmake --version`
    echo "$version has been installed"
fi

#install protobuf

#VERSION=2.6.1, the version of protobuf must be 2.5.0, otherwise build failure...
#such as : [ERROR] Failed to execute goal org.apache.hadoop:hadoop-maven-plugins:2.7.2:protoc (compile-protoc) on project hadoop-common: org.apache.maven.plugin.MojoExecutionException: protoc version is 'libprotoc 2.6.1', expected version is '2.5.0' -> [Help 1]

VERSION=2.5.0

version=`protoc --version`

if [ $version != $VERSION ]; then

    rm -r /usr/local/protobuf > /dev/null 2>$1

    URL=https://github.com/google/protobuf/releases/download/v$VERSION/protobuf-$VERSION.tar.gz
    wget -c $URL 

    tar xf protobuf-$VERSION.tar.gz
    mv protobuf-$VERSION.tar.gz protobuf
    wget -c $URL 

    tar xf protobuf-2.6.1.tar.gz
    mv protobuf-2.6.1.tar.gz protobuf
    cd protobuf

    ./configure
    make
    make check
    make install
    ldconfig

    protoc --version
    if [ $? -eq 0 ]; then
         echo "Protobuf $VERSION installed successfully"
    fi 
else
    version=`protoc --version`
    echo "Protobuf $version has been installed"
fi

# download and make hadoop
cd /usr/local
if [ !d hadoop ]; then
    mkdir hadoop
fi
cd hadoop

HADOOP_URL=http://apache.01link.hk/hadoop/common/hadoop-2.7.2/hadoop-2.7.2-src.tar.gz 
wget -c $HADOOP_URL 
tar xvf hadoop-2.7.2-src.tar.gz
cd hadoop-2.7.2-src/

mvn package -Pdist,native -DskipTests –Dtar
