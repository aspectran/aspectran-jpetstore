#!/bin/sh

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

if [ -f "$SCRIPT_DIR/app.conf" ]; then
  . "$SCRIPT_DIR/app.conf"
elif [ -f "$SCRIPT_DIR/../app.conf" ]; then
  . "$SCRIPT_DIR/../app.conf"
else
  echo "Error: app.conf file not found."
  exit 1
fi

echo "Uninstalling service $APP_NAME ..."

SERVICE_FILE="/etc/systemd/system/$APP_NAME.service"

if [ ! -f "$SERVICE_FILE" ]; then
  echo "Service $APP_NAME could not be found."
  exit 3
fi

sudo systemctl stop $APP_NAME 2>/dev/null || true
sudo systemctl disable $APP_NAME 2>/dev/null || true

echo "Removing service file: $SERVICE_FILE"
sudo rm -f "$SERVICE_FILE" || exit 1

sudo systemctl daemon-reload || exit 1
sudo systemctl reset-failed 2>/dev/null || true
echo "Service $APP_NAME has been uninstalled successfully."
