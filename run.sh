#!/bin/bash

docker run --rm -it \
 -eCONTAINER_LOG_LEVEL=0 \
 -eSESSION_SAVE_PATH=/tmp/ \
 forestsoft/php-apache:8.1 bash