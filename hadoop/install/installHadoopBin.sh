#!/bin/bash

# we use primary haddop, version 2.5.2
# refer:http://hadoop.apache.org/docs/r2.5.2/hadoop-project-dist/hadoop-common/SingleCluster.html#Standalone_Operation

cd /usr/local
mkdir hadoop && cd hadoop

URL=http://mirror.hust.edu.cn/apache/hadoop/common/hadoop-2.5.2/hadoop-2.5.2.tar.gz
wget -c $URL

# unpack...

# set JAVA_HOME for hadoop

# test
bin/hadoop version
