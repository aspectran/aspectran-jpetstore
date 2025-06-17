#!/bin/sh

. ./app.conf

echo "Deploying configurations to $DEPLOY_DIR/config ..."
rm -rf "${DEPLOY_DIR:?}"/config/*
[ -d "$REPO_DIR/app/config" ] && cp -pR "$REPO_DIR"/app/config/* "$DEPLOY_DIR/config"

echo "Restore specific configuration files after deployment ..."
[ -d "$RESTORE_DIR/config" ] && cp -pRf "$RESTORE_DIR"/config/* "$DEPLOY_DIR/config"
