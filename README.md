# forestsoft/php-apache
[![QA](https://github.com/ForestsoftGmbH/docker-apache-php/actions/workflows/build.yaml/badge.svg)](https://github.com/ForestsoftGmbH/docker-apache-php/actions/workflows/build.yaml)
[![Docker Pulls](https://img.shields.io/docker/pulls/forestsoft/php-apache.svg)](https://hub.docker.com/r/forestsoft/php-apache/)
[![Docker Stars](https://img.shields.io/docker/stars/forestsoft/php-apache.svg)](https://hub.docker.com/r/forestsoft/php-apache/)
[![Docker Image Version (latest semver)](https://img.shields.io/docker/v/forestsoft/php-apache?sort=semver)](https://hub.docker.com/r/forestsoft/php-apache/)
[![Docker Image Size (latest semver)](https://img.shields.io/docker/image-size/forestsoft/php-apache?sort=semver)](https://hub.docker.com/r/forestsoft/php-apache/)

This image is an addition to base implementation of official docker php apache image with 
customized apache and php configuration.

## Usage

If you want to use this image as a base image for your own project, you can use the following Dockerfile:

```Dockerfile
FROM forestsoft/php-apache:8.1
export APP_HOST=example.com
COPY . /var/www/html
```

The app host variable will be used to create an self signed SSL certificate for the given domain.

You can also start the container with the following command:

```bash
docker run --rm -e APP_HOST=example.com -v $(pwd):/var/www/html -p 80:80 -p 443:443 forestsoft/php-apache:8.1
```
### Customizing

you can exectute the custom scripts right before apache or container is started:

Place your scripts for container boot in the following folders:

/usr/local/bin/forestsoft/init-container/custom-init/


Before apache is started the following folders are executed:

/usr/local/bin/forestsoft/init-apache/custom-init/

## Debugging mode
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

#### Configuration Overview

| Enviroment variable      | Description                            | Default value | Possible Values                              |
| ------------------------ | ---------------------------------      | ------------- | ---------------                              | 
| PHP_ERR_REPORTING        | set the level of error reporting       |   8183        | any integer value of error_reporting()      | 
| SESSION_HANDLER          | in case of redis session usage         |   Not set     | redis                                        | 
| SESSION_SAVE_PATH        | define there the session should stored |   Not set     | tcp://redis:6379                             | 

### Development version:
The development version depends on production and install additional packages:

- xdebug

There is also a different memory limit of 1024MB for development version.

In order to be able to debug set the environment variable XDEBUG_ENABLED=1 and set the ip address of your host machine in envirorment variable XDEBUG_IP=host.docker.internal

#### Configuration Overview

| Enviroment variable      | Description                            | Default value | Possible Values                              |
| ------------------------ | ---------------------------------      | ------------- | ---------------                              | 
| XDEBUG_ENABLED           | If its set xdebug will be setuped      |   Not set     | 1                                            | 
| XDEBUG_IP                | ip where xdebug should connect to      |   Not set     | 127.0.0.1,host.docker.internal               | 

 