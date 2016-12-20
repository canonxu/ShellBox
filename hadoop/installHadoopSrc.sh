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

# [Failure]
# build hadoop with maven, sufficient memory is needed
# for my aliyun host, the RAM is only 1G, alwasys prompt cannot allocate memory(OOM) even though i set MAVEN_OPTs='Xms128m, Xmx1000m'
# then i try deploy hadoop on docker
mvn package -Pdist,native -DskipTests -Dtar

: <<'END'
INFO] ------------------------------------------------------------------------
[INFO] Reactor Summary:
[INFO] 
[INFO] Apache Hadoop Main ................................ SUCCESS [3.518s]
[INFO] Apache Hadoop Project POM ......................... SUCCESS [2.450s]
[INFO] Apache Hadoop Annotations ......................... SUCCESS [4.289s]
[INFO] Apache Hadoop Assemblies .......................... SUCCESS [0.427s]
[INFO] Apache Hadoop Project Dist POM .................... SUCCESS [2.482s]
[INFO] Apache Hadoop Maven Plugins ....................... SUCCESS [5.726s]
[INFO] Apache Hadoop MiniKDC ............................. SUCCESS [5.220s]
[INFO] Apache Hadoop Auth ................................ SUCCESS [5.676s]
[INFO] Apache Hadoop Auth Examples ....................... SUCCESS [3.786s]
[INFO] Apache Hadoop Common .............................. SUCCESS [1:59.889s]
[INFO] Apache Hadoop NFS ................................. SUCCESS [11.532s]
[INFO] Apache Hadoop Common Project ...................... SUCCESS [0.034s]
[INFO] Apache Hadoop HDFS ................................ FAILURE [1:53.622s]
[INFO] Apache Hadoop HttpFS .............................. SKIPPED
[INFO] Apache Hadoop HDFS BookKeeper Journal ............. SKIPPED
[INFO] Apache Hadoop HDFS-NFS ............................ SKIPPED
[INFO] Apache Hadoop HDFS Project ........................ SKIPPED
[INFO] hadoop-yarn ....................................... SKIPPED
[INFO] hadoop-yarn-api ................................... SKIPPED
[INFO] hadoop-yarn-common ................................ SKIPPED
[INFO] hadoop-yarn-server ................................ SKIPPED
[INFO] hadoop-yarn-server-common ......................... SKIPPED
[INFO] hadoop-yarn-server-nodemanager .................... SKIPPED
[INFO] hadoop-yarn-server-web-proxy ...................... SKIPPED
[INFO] hadoop-yarn-server-applicationhistoryservice ...... SKIPPED
[INFO] hadoop-yarn-server-resourcemanager ................ SKIPPED
[INFO] hadoop-yarn-server-tests .......................... SKIPPED
[INFO] hadoop-yarn-client ................................ SKIPPED
[INFO] hadoop-yarn-applications .......................... SKIPPED
[INFO] hadoop-yarn-applications-distributedshell ......... SKIPPED
[INFO] hadoop-yarn-applications-unmanaged-am-launcher .... SKIPPED
[INFO] hadoop-yarn-site .................................. SKIPPED
[INFO] hadoop-yarn-project ............................... SKIPPED
[INFO] hadoop-mapreduce-client ........................... SKIPPED
[INFO] hadoop-mapreduce-client-core ...................... SKIPPED
[INFO] hadoop-mapreduce-client-common .................... SKIPPED
[INFO] hadoop-mapreduce-client-shuffle ................... SKIPPED
[INFO] hadoop-mapreduce-client-app ....................... SKIPPED
[INFO] hadoop-mapreduce-client-hs ........................ SKIPPED
[INFO] hadoop-mapreduce-client-jobclient ................. SKIPPED
[INFO] hadoop-mapreduce-client-hs-plugins ................ SKIPPED
[INFO] Apache Hadoop MapReduce Examples .................. SKIPPED
[INFO] hadoop-mapreduce .................................. SKIPPED
[INFO] Apache Hadoop MapReduce Streaming ................. SKIPPED
[INFO] Apache Hadoop Distributed Copy .................... SKIPPED
[INFO] Apache Hadoop Archives ............................ SKIPPED
[INFO] Apache Hadoop Rumen ............................... SKIPPED
[INFO] Apache Hadoop Gridmix ............................. SKIPPED
[INFO] Apache Hadoop Data Join ........................... SKIPPED
[INFO] Apache Hadoop Extras .............................. SKIPPED
[INFO] Apache Hadoop Pipes ............................... SKIPPED
[INFO] Apache Hadoop OpenStack support ................... SKIPPED
[INFO] Apache Hadoop Client .............................. SKIPPED
[INFO] Apache Hadoop Mini-Cluster ........................ SKIPPED
[INFO] Apache Hadoop Scheduler Load Simulator ............ SKIPPED
[INFO] Apache Hadoop Tools Dist .......................... SKIPPED
[INFO] Apache Hadoop Tools ............................... SKIPPED
[INFO] Apache Hadoop Distribution ........................ SKIPPED
[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 4:43.336s
[INFO] Finished at: Tue Dec 20 13:30:56 CST 2016
[INFO] Final Memory: 63M/321M
END

