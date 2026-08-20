#!/bin/sh
# Pulls the latest source code from the Git repository.
# If the repository is not cloned yet, it will be cloned.

set -e

# Check if git is installed
command -v git >/dev/null || { echo "Error: git is not installed. Please install git and try again."; exit 1; }

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
. "$SCRIPT_DIR/app.conf"

if [ "$DEV_MODE" = "true" ]; then
  echo "Development environment detected."
  echo "Pulling latest changes in the current Git working tree ($SCRIPT_DIR) ..."
  git -C "$SCRIPT_DIR" pull
  exit 0
fi

if [ ! -d "$REPO_DIR" ]; then
  [ ! -d "$BUILD_DIR" ] && mkdir -p "$BUILD_DIR"
  cd "$BUILD_DIR"
  git clone "$REPO_URL" "$APP_NAME"
else
  cd "$REPO_DIR"
  git pull
fi
