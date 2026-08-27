#!/bin/sh
# Deploys web application (front-end) files.
# It also restores specific web application files from the restore directory.

set -e

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
cd "$SCRIPT_DIR"
. "$SCRIPT_DIR/app.conf"

# Auto-detect development mode if not explicitly set
if [ -z "$DEV_MODE" ] && [ -f "$SCRIPT_DIR/pom.xml" ] && git -C "$SCRIPT_DIR" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  DEV_MODE=true
fi

if [ "$DEV_MODE" = "true" ]; then
  echo "Development environment detected."
  echo "Skipping webapps deployment to preserve version-controlled files in $DEPLOY_DIR/webapps."
  exit 0
fi

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
