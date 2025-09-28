#!/bin/sh
# Checks the status of the application service using systemctl.

set -e

# Check if systemctl is installed
command -v systemctl >/dev/null || { echo "Error: systemctl is not installed."; exit 1; }

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
. "$SCRIPT_DIR/app.conf"

sudo systemctl status "$APP_NAME"
