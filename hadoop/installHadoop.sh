#!/bin/bash

# install java-7
apt-get install openjdk-7-jdk
sed "-a export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" ~/.zshrc
source ~/.zshrc

# install maven
apt-get install maven

# install cmake
apt-get install cmake
