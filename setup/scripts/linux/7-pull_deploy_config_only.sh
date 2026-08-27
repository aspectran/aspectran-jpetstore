#!/bin/sh
# Pulls the latest source and deploys configuration files only.

set -e

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
cd "$SCRIPT_DIR"

./1-pull.sh "$@"
./3-deploy_config.sh
