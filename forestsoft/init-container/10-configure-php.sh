#!/bin/bash
. /usr/local/bin/forestsoft/functions.sh

if [ "${XDEBUG_ENABLED:-""}" != "" ]; then
  write_config "xdebug.client_host" "$XDEBUG_IP" "docker-php-ext-xdebug.ini"
  write_config "xdebug.client_mode" "debug" "docker-php-ext-xdebug.ini"
fi
write_config "error_reporting" "$PHP_ERR_REPORTING"
write_config "session.save_handler" "$SESSION_HANDLER"
write_config "session.save_path" "$SESSION_SAVE_PATH"