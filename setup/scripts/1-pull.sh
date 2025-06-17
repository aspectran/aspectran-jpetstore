#!/bin/sh

. ./app.conf

if [ ! -d "$REPO_DIR" ]; then
  [ ! -d "$BUILD_DIR" ] && mkdir "$BUILD_DIR"
  cd "$BUILD_DIR" || exit
  git clone "$REPO_URL" "$APP_NAME"
else
  cd "$REPO_DIR" || exit
  git pull
fi
