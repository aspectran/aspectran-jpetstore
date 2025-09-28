#!/bin/sh

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
. "$SCRIPT_DIR/app.conf"

if [ ! -d "$REPO_DIR" ]; then
  [ ! -d "$BUILD_DIR" ] && mkdir "$BUILD_DIR"
  cd "$BUILD_DIR" || exit
  git clone "$REPO_URL" "$APP_NAME"
else
  cd "$REPO_DIR" || exit
  git pull
fi
