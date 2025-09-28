#!/bin/sh
# Starts the interactive shell with debug mode enabled.

set -e

. ./app.conf

"$DEPLOY_DIR/bin/shell.sh" --debug
