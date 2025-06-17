#!/bin/sh

. ./app.conf

echo "Uninstalling service $APP_NAME ..."

SERVICE_FILE="/etc/systemd/system/$APP_NAME.service"

if [ ! -f "$SERVICE_FILE" ]; then
  echo "Service $APP_NAME could not be found."
  exit 3
fi

sudo systemctl stop $APP_NAME
sudo systemctl disable $APP_NAME
sudo systemctl cat $APP_NAME | sudo gawk 'NR==1 && $1=="#"{system("rm -v "$2)}' || exit
sudo systemctl daemon-reload || exit
sudo systemctl reset-failed || exit
echo "Service $APP_NAME has been uninstalled successfully."
