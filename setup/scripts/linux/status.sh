#!/bin/sh
# Checks the status of the application service using systemctl.

set -e

# Check if systemctl is installed
command -v systemctl >/dev/null || { echo "Error: systemctl is not installed."; exit 1; }

. ./app.conf

sudo systemctl status "$APP_NAME"
