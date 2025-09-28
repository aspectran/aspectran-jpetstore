#!/bin/sh
# A wrapper script to run the jsvc daemon with the correct application context.

set -e

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
. "$SCRIPT_DIR/app.conf"

"$DEPLOY_DIR/bin/jsvc-daemon.sh" --proc-name "$PROC_NAME" --pid-file "$PID_FILE" --user "$DAEMON_USER" "$1"
