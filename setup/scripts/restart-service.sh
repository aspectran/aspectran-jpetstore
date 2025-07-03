#!/bin/sh

. ./app.conf

echo "Restarting service $APP_NAME ..."
sudo systemctl restart $APP_NAME || exit
sudo systemctl --no-pager status $APP_NAME
echo "Service $APP_NAME restarted successfully."
