#!/bin/sh
# Builds the application using Maven and deploys the libraries.

set -e

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
. "$SCRIPT_DIR/app.conf"

# Check if mvn is installed
command -v mvn >/dev/null || { echo "Error: Maven (mvn) is not installed. Please install it and try again."; exit 1; }

echo "========================================================================"
echo "Build Environment"
echo "------------------------------------------------------------------------"
[ -n "$JAVA_HOME" ] && echo "JAVA_HOME: $JAVA_HOME"
echo "which mvn: $(command -v mvn)"
mvn -version
echo "========================================================================"

if [ "$DEV_MODE" = "true" ]; then
  echo "Development environment detected. Building in $SCRIPT_DIR ..."
  cd "$SCRIPT_DIR"
  mvn $MAVEN_ARGS clean package -U -Dmaven.test.skip=true "$@"
  exit 0
fi

cd "$REPO_DIR"

mvn $MAVEN_ARGS clean package -U -Dmaven.test.skip=true "$@"

echo "Deploying libraries to $DEPLOY_DIR/lib ..."
rm -rf "${DEPLOY_DIR:?}"/lib/*
[ -d "$REPO_DIR/app/lib" ] && cp -pR "$REPO_DIR"/app/lib/* "$DEPLOY_DIR/lib"
rm -f "$DEPLOY_DIR/lib/.ignore"
