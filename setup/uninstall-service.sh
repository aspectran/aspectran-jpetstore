#!/bin/sh

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
. "$SCRIPT_DIR/app.conf"

echo "Uninstalling service $APP_NAME ..."

SERVICE_FILE="/etc/systemd/system/$APP_NAME.service"

if [ ! -f "$SERVICE_FILE" ]; then
  echo "Service $APP_NAME could not be found."
  exit 3
fi

sudo systemctl stop $APP_NAME
sudo systemctl disable $APP_NAME

echo "Removing service file: $SERVICE_FILE"
sudo rm -v "$SERVICE_FILE" || exit

sudo systemctl daemon-reload || exit
sudo systemctl reset-failed || exit
echo "Service $APP_NAME has been uninstalled successfully."
