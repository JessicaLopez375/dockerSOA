#!/bin/bash

DIR=`pwd`


TOMCAT_HOME="$DIR/tomcat"
WEB_ROOT="$TOMCAT_HOME/webapps/ROOT"
NODERED_HOME="$DIR/node-red-data"
MOSQUITTO_HOME="$DIR/mosquitto"

DOMAIN=`cat domain.cfg`

echo "renovando dominio $DOMAIN"

sudo certbot certonly --webroot --webroot-path $WEB_ROOT --force-renewal -d $DOMAIN

sudo cp /etc/letsencrypt/live/$DOMAIN/cert.pem $TOMCAT_HOME/cert
sudo cp /etc/letsencrypt/live/$DOMAIN/chain.pem $TOMCAT_HOME/cert
sudo cp /etc/letsencrypt/live/$DOMAIN/privkey.pem $TOMCAT_HOME/cert

sudo cp /etc/letsencrypt/live/$DOMAIN/cert.pem $NODERED_HOME/cert
sudo cp /etc/letsencrypt/live/$DOMAIN/privkey.pem $NODERED_HOME/cert

sudo cp /etc/letsencrypt/live/$DOMAIN/cert.pem $MOSQUITTO_HOME/cert
sudo cp /etc/letsencrypt/live/$DOMAIN/chain.pem $MOSQUITTO_HOME/cert
sudo cp /etc/letsencrypt/live/$DOMAIN/privkey.pem $MOSQUITTO_HOME/cert



sudo chown $USER $TOMCAT_HOME/cert/*.pem
sudo chown $USER $NODERED_HOME/cert/*.pem


docker restart nodered tomcat mosquitto
