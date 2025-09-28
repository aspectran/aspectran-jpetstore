#!/bin/sh
# The target script for the systemd service to start the application.

set -e

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
. "$SCRIPT_DIR/app.conf"

case "$1" in
-f | --force)
  [ -f "$PID_FILE" ] && rm -f "$PID_FILE"
  [ -f "$LOCK_FILE" ] && rm -f "$LOCK_FILE"
  ;;
esac

"$DEPLOY_DIR/bin/jsvc-daemon.sh" \
  --proc-name "$PROC_NAME" \
  --pid-file "$PID_FILE" \
  --user "$DAEMON_USER" \
  start
