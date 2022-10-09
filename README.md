# docker-apache-php

This image is a base implementation of official docker php image with customized apache and php configuration.

## Usage

debugging mode

```bash
docker run --rm -it \
 -eCONTAINER_LOG_LEVEL=3 \
 -eSESSION_SAVE_PATH=/tmp/ \
 forestsoft/php-apache:8.1 bash
```