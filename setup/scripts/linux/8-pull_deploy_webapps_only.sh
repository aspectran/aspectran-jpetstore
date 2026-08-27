#!/bin/sh
# Pulls the latest source and deploys webapps files only.

set -e

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
cd "$SCRIPT_DIR"

./1-pull.sh "$@"
./4-deploy_webapps.sh
