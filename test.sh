#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
IMAGE=${IMAGE:-"forestsoft/php-apache:8.1"}
CONTAINER_NAME="container_under_test"
LOG_LEVEL=0
function break_test() {
    echo -e "${RED}Something went wrong: $1"
    echo -e $NC
    docker inspect --format "{{json .State }}" $CONTAINER_NAME | jq
    docker logs container_under_test
}

docker rm -f container_under_test > /dev/null 2>&1 || true
ID=$(docker run -d -eCONTAINER_LOG_LEVEL=$LOG_LEVEL --name $CONTAINER_NAME $IMAGE)
# until [ "`docker inspect -f {{.State.Running}} container_under_test`"=="true" ]; do
while true; do
    set -e -o pipefail
    status=$(docker inspect --format "{{json .State }}" $CONTAINER_NAME | jq -r '.Status')
    set +e +o pipefail
    if [ "$status" = "exited" ]; then
        echo ""
        break_test "Container exited"
        exit 1
        break
    fi
    if [ "$status" = "running" ]; then
       healthCheck=$(docker inspect --format "{{json .State }}" $CONTAINER_NAME | jq -r '.Health.Status')
       retries=$(docker inspect --format "{{json .State }}" $CONTAINER_NAME | jq -r '.Health.FailingStreak')
       if [ "$healthCheck" != "starting" ]; then
            if [ "$healthCheck" == "unhealthy" ]; then
                break_test "Container is not healthy"
                exit 1
            fi
       fi
       if [ "$healthCheck" = "healthy" ]; then
           echo -e "${GREEN}Container is running successfully${NC}"
           exit 0
       fi
       if [ $retries -gt 10 ]; then
            break_test "Health-check failed more than 10 times"
       fi
    fi
    sleep 0.1;
done;