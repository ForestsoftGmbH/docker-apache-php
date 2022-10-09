#!/bin/bash
if [ -z $APP_HOST ]; then
  APP_HOST="localhost"
fi
httpStatus=$(curl --write-out '%{http_code}' --silent --output /dev/null -H "Host: $APP_HOST" -k https://localhost/health/)
if [ $httpStatus == "200" ]; then
  result=$(curl -H "Host: ${APP_HOST}" -k https://localhost/health/)
  if [ "$result" == "Healthy" ]; then
    exit 0
  fi
  exit 0
else
  exit 1
fi