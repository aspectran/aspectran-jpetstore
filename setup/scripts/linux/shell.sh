#!/bin/sh
# Starts the interactive shell with debug mode enabled.

set -e

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
cd "$SCRIPT_DIR"
. "$SCRIPT_DIR/app.conf"

"$DEPLOY_DIR/bin/shell.sh" --debug
