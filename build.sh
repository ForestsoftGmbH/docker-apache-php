#!/bin/bash
set -e
IMAGE_NAME="forestsoft/php-apache"
PHP_VERSION=${PHP_VERSION:-"8.1"}
IMAGE_TAG="$PHP_VERSION"
BASE_IMAGE_TAG=${BASE_IMAGE_TAG:-"$IMAGE_TAG"}
TARGET=${TARGET:-"production"}
if [ "$1" == "dev" ]; then
  IMAGE_TAG="$IMAGE_TAG-dev"
  BASE_IMAGE_TAG=${BASE_IMAGE_TAG:-"$IMAGE_TAG"}
  TARGET="dev"
fi

docker build \
    --cache-from "$IMAGE_NAME:$IMAGE_TAG" \
    -t ${IMAGE_NAME}:${IMAGE_TAG} \
    --build-arg BASE_IMAGE="${IMAGE_NAME}:${BASE_IMAGE_TAG}" \
    --build-arg PHP_VERSION="${PHP_VERSION}" \
    --target="$TARGET" \
    .
SIZE=$(docker images $IMAGE_NAME:$IMAGE_TAG --format "{{.Size}}")

echo "image_tag=$IMAGE_TAG" >> $GITHUB_OUTPUT
echo "image_name=$IMAGE_NAME" >> $GITHUB_OUTPUT
echo "image_size=${SIZE/MB/}" >> $GITHUB_OUTPUT