#!/bin/sh

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
. "$SCRIPT_DIR/app.conf"

sudo systemctl status $APP_NAME
