#!/bin/bash

# Function: Install java by apt

# Example: root, and bash installJava.sh

VERSION="openjdk-7-jdk"

apt-get install $VERSION
echo "install $VERSION successfully"

JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
export $JAVA_HOME
echo "set JAVA_HOME=$JAVA_HOME successfully"


