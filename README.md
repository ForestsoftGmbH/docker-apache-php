# forestsoft/php-apache

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
### Debugging mode
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

There is also a different memory limit of 1024MB for development version.