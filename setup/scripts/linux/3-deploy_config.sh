#!/bin/sh
# Deploys configuration files.
# It also restores specific configuration files from the restore directory.

set -e

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
. "$SCRIPT_DIR/app.conf"

echo "Deploying configurations to $DEPLOY_DIR/config ..."
rm -rf "${DEPLOY_DIR:?}"/config/*
if [ -d "$REPO_DIR/app/config" ] && [ -n "$(ls -A "$REPO_DIR"/app/config)" ]; then
  cp -pR "$REPO_DIR"/app/config/* "$DEPLOY_DIR"/config
fi

echo "Restore specific configuration files after deployment ..."
if [ -d "$RESTORE_DIR/config" ] && [ -n "$(ls -A "$RESTORE_DIR"/config)" ]; then
  cp -pRf "$RESTORE_DIR"/config/* "$DEPLOY_DIR"/config
fi
