#!/bin/sh
# Tails a specified log file from the application's log directory.

set -e

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
. "$SCRIPT_DIR/app.conf"

tail -f "$DEPLOY_DIR/logs/$1.log"
