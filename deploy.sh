#!/bin/bash

DIR=`pwd`

TOMCAT_HOME="$DIR/tomcat"

rm -rf /tmp/SOA2021
cd /tmp

git clone https://github.com/sofiapfeigin/SOA2021

docker run -it --rm --name mvn -v "$HOME/.m2":/root/.m2 -v /tmp/SOA2021:/usr/src/mymaven -w /usr/src/mymaven maven:3.6.3-jdk-11 mvn package -Dspring.profiles.active=mysql -DskipTests -Dbuild=war 

docker stop tomcat

rm -rf $TOMCAT_HOME/webapps/ROOT
mkdir $TOMCAT_HOME/webapps/ROOT

cp /tmp/SOA2021/target/ROOT.war $TOMCAT_HOME/webapps/ROOT/ROOT.zip

cd $TOMCAT_HOME/webapps/ROOT

unzip ROOT.zip

rm ROOT.zip


docker start tomcat
