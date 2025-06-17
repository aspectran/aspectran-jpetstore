#!/bin/sh

. ./app.conf

cd "$REPO_DIR" || exit
mvn clean package -U -Dmaven.test.skip=true $1

echo "Deploying libraries to $DEPLOY_DIR/lib ..."
rm -rf "${DEPLOY_DIR:?}"/lib/*
[ -d "$REPO_DIR/app/lib" ] && cp -pR "$REPO_DIR"/app/lib/* "$DEPLOY_DIR/lib"
