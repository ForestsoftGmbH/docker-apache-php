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

## Contents

This image contains following php extension pre-installed:

### Production version:
- gd
- redis
- zip
- pdo_mysql
- simplexml


### Development version:
The development version depends on production and install additional packages:

- xdebug