#!/bin/sh
# Tails a specified log file from the application's log directory.

set -e

. ./app.conf

tail -f "$DEPLOY_DIR/logs/$1.log"
