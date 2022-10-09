#!/bin/bash
set -e
IMAGE_NAME="forestsoft/php-apache"
PHP_VERSION="8.1"
IMAGE_TAG="$PHP_VERSION"
TARGET="production"

docker build \
    -t ${IMAGE_NAME}:${IMAGE_TAG} \
    --build-arg BASE_IMAGE="${IMAGE_NAME}:${IMAGE_TAG}" \
    --target="$TARGET" \
    .

echo "::set-output name=image_tag::$IMAGE_TAG"
echo "::set-output name=image_name::$IMAGE_NAME"