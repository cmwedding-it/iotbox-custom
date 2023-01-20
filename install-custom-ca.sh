#!/bin/bash

CONF_PATH="rootfs/etc/nginx"

cat conf/default.nginx > $CONF_PATH/sites-enabled/default

mkdir -p $CONF_PATH/ssl

cp conf/*.crt $CONF_PATH/ssl/cert.crt
cp conf/*.key $CONF_PATH/ssl/privkey.key