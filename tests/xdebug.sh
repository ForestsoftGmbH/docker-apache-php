#!/bin/bash
set -e
xdebug.sh enable
result=$(php -v | grep Xdebug)
if [ "$?" != "0" ]; then
  echo "Xdebug is not available"
  php -v
  exit 1
fi
