#!/bin/bash

. /usr/local/bin/forestsoft/functions.sh

if [ "${XDEBUG_ENABLED:-""}" != "" ]; then
  write_config "xdebug.client_host" "$XDEBUG_IP" "docker-php-ext-xdebug.ini"
  write_config "xdebug.client_mode" "debug" "docker-php-ext-xdebug.ini"
fi