#!/bin/sh
if [ ! -f "/etc/ssl/certs/ssl-cert-snakeoil.pem" ]; then
  if [ "${APP_HOST:-""}" = "" ]; then
    export APP_HOST="localhost"
  fi
  log_info ""
  log_info "Genereating SSL certificate for Host $APP_HOST"
  log_info ""
  openssl req -x509 -subj "/CN=${APP_HOST}" -nodes -days 365 -newkey rsa:4096 -keyout /etc/ssl/private/ssl-cert-snakeoil.key -out /etc/ssl/certs/ssl-cert-snakeoil.pem
fi