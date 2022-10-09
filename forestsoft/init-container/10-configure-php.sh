#!/bin/bash
. /usr/local/bin/forestsoft/functions.sh

write_config "error_reporting" "$PHP_ERR_REPORTING"
write_config "session.save_handler" "$SESSION_HANDLER"
write_config "session.save_path" "$SESSION_SAVE_PATH"