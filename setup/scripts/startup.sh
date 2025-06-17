#!/bin/sh

. ./app.conf

[ -f "$PID_FILE" ] && rm -f "$PID_FILE"
[ -f "$LOCK_FILE" ] && rm -f "$LOCK_FILE"

"$DEPLOY_DIR/bin/jsvc-daemon.sh" \
  --proc-name "$PROC_NAME" \
  --pid-file "$PID_FILE" \
  --user "$DAEMON_USER" \
  start
