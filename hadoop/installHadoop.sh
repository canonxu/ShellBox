#!/bin/bash

# Function: install hadoop

# Example: sudo bash installHadoop.sh

# install java-7
apt-get install openjdk-7-jdk
#sed -i "$a export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" ~/.zshrc
#source ~/.zshrc

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


# install protobuf
# note: do not forget to locate the path of installProtobuf.sh

# VERSION=2.6.1, the version of protobuf must be 2.5.0, otherwise build failure...
#such as : [ERROR] Failed to execute goal org.apache.hadoop:hadoop-maven-plugins:2.7.2:protoc (compile-protoc) on project hadoop-common: org.apache.maven.plugin.MojoExecutionException: protoc version is 'libprotoc 2.6.1', expected version is '2.5.0' -> [Help 1]

sh installProtobuf.sh 2.5.0


# download hadoop
cd /usr/local
if [ !d hadoop ]; then
    mkdir hadoop
fi
cd hadoop

HADOOP_URL=http://apache.01link.hk/hadoop/common/hadoop-2.7.2/hadoop-2.7.2-src.tar.gz 
wget -c $HADOOP_URL 
tar xvf hadoop-2.7.2-src.tar.gz
cd hadoop-2.7.2-src/

# build hadoop with maven, sufficient memory is needed
mvn package -Pdist,native -DskipTests -Dtar

