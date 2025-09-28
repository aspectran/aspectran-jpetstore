#!/bin/sh
# The target script for the systemd service to stop the application.

set -e

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
. "$SCRIPT_DIR/app.conf"

"$DEPLOY_DIR/bin/jsvc-daemon.sh" \
  --proc-name "$PROC_NAME" \
  --pid-file "$PID_FILE" \
  --user "$DAEMON_USER" \
  stop
