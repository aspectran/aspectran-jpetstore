#!/bin/sh
# A wrapper script to control the application service using systemctl.

set -e

# Check if systemctl is installed
command -v systemctl >/dev/null || { echo "Error: systemctl is not installed."; exit 1; }

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
. "$SCRIPT_DIR/app.conf"

case "$1" in
  start|stop|restart|status|enable|disable)
    echo "Executing 'systemctl $1 $APP_NAME' ..."
    sudo systemctl "$1" "$APP_NAME"
    if [ "$1" = "start" ] || [ "$1" = "restart" ]; then
        sudo systemctl --no-pager status "$APP_NAME"
    fi
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|status|enable|disable}"
    exit 1
    ;;
esac
