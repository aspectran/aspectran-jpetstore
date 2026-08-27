#!/bin/sh
# Pulls the latest source, builds the application, and deploys all components.

set -e

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
cd "$SCRIPT_DIR"

./1-pull.sh "$@"
./2-build.sh
./3-deploy_config.sh
./4-deploy_webapps.sh
