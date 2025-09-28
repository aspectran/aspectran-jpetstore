#!/bin/sh
# Deploys web application (front-end) files.
# It also restores specific web application files from the restore directory.

set -e

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
. "$SCRIPT_DIR/app.conf"

echo "Deploying web applications to $DEPLOY_DIR/webapps ..."
if [ -d "$REPO_DIR/app/webapps" ]; then
  [ ! -d "$DEPLOY_DIR/webapps" ] && mkdir -p "$DEPLOY_DIR/webapps"
  rm -rf "${DEPLOY_DIR:?}"/webapps/*
  if [ -n "$(ls -A "$REPO_DIR"/app/webapps)" ]; then
    cp -pR "$REPO_DIR"/app/webapps/* "$DEPLOY_DIR"/webapps
  fi
fi

echo "Restore specific web application files after deployment ..."
if [ -d "$RESTORE_DIR/webapps" ] && [ -n "$(ls -A "$RESTORE_DIR"/webapps)" ]; then
  cp -pRf "$RESTORE_DIR"/webapps/* "$DEPLOY_DIR"/webapps
fi
