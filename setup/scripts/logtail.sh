#!/bin/sh

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
. "$SCRIPT_DIR/app.conf"

tail -f "$DEPLOY_DIR/logs/$1.log"
