#!/bin/sh

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
. "$SCRIPT_DIR/app.conf"

echo "Restarting service $APP_NAME ..."
sudo systemctl restart $APP_NAME || exit
sudo systemctl --no-pager status $APP_NAME
echo "Service $APP_NAME restarted successfully."
