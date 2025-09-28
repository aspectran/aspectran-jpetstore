#!/bin/sh
# Restarts the application service using systemctl.

set -e

# Check if systemctl is installed
command -v systemctl >/dev/null || { echo "Error: systemctl is not installed."; exit 1; }

. ./app.conf

echo "Restarting service $APP_NAME ..."
sudo systemctl restart "$APP_NAME"
sudo systemctl --no-pager status "$APP_NAME"
echo "Service $APP_NAME restarted successfully."
