#!/bin/bash
export CONTAINER_LOG_LEVEL=${CONTAINER_LOG_LEVEL:-0}
function includeScriptDir() {
    if [[ -d "$1" ]]; then
        for FILE in "$1"/*.sh; do
            log_info "-> Executing ${FILE}"
            # run custom scripts, only once
            . "$FILE"
        done
    fi
}
function write_config() {
  if [ -n "$3" ]; then
    conf=$3
  else 
    conf=50-forestsoft.ini
  fi
  if [ -n "$1" ] && [ -n "$2" ]; then
     log_debug "Writing $1=$2 to /usr/local/etc/php/conf.d/$conf"
     echo "$1 = $2" >> /usr/local/etc/php/conf.d/$conf
  fi    
}

function log() {
  type=$1
  message=$2
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $message"
}

function log_debug() {
  if [ ${CONTAINER_LOG_LEVEL} -gt 1 ]; then
    log "debug" "$1"
  fi
}
function log_info() {
  if [ ${CONTAINER_LOG_LEVEL} -gt 0 ]; then
    log "info" "$1"
  fi
}
function log_error() {
    log "error" "$1"
}