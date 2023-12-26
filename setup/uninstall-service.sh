#!/bin/sh

. ./app.conf

echo "Uninstalling /etc/init.d/$APP_NAME ..."

if [ -f "/etc/init.d/$APP_NAME" ]; then
  sudo update-rc.d "$APP_NAME" remove || exit
  sudo rm "/etc/init.d/$APP_NAME" || exit
  echo "Service $APP_NAME has been uninstalled successfully."
else
  echo "Service $APP_NAME could not be found."
fi