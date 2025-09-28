#!/bin/sh
# The target script for the systemd service to stop the application.

set -e

. ./app.conf

"$DEPLOY_DIR/bin/jsvc-daemon.sh" \
  --proc-name "$PROC_NAME" \
  --pid-file "$PID_FILE" \
  --user "$DAEMON_USER" \
  stop
