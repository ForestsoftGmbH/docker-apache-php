ARG PHP_VERSION="8.1"
ARG COMPOSER_VERSION="2.4"
ARG BASE_IMAGE="forestsoft/apache-php"

FROM composer:${COMPOSER_VERSION} AS composer
FROM php:${PHP_VERSION}-apache as production
ENV COMPOSER_HOME=/var/www/.composer
COPY ./docker-php-entrypoint /usr/local/bin/docker-php-entrypoint
COPY ./forestsoft /usr/local/bin/forestsoft
COPY ./php.ini /usr/local/etc/php/php.ini
COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN apt-get clean \
    && apt update \
    && apt install -y nano curl zip libzip-dev libpng-dev libfreetype6-dev libjpeg62-turbo-dev libxml2-dev openssl \ 
    && a2enmod ssl rewrite \
    && a2ensite default-ssl \
    && docker-php-ext-install -j$(nproc) gd intl pdo pdo_mysql zip mbstring simplexml mysqli opcache

RUN  apt-get clean \
     && rm -Rf /var/lib/apt/lists/ 

FROM $BASE_IMAGE as dev
