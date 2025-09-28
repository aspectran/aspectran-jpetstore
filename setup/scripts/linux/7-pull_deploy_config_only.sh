#!/bin/sh
# Pulls the latest source and deploys configuration files only.

set -e

./1-pull.sh
./3-deploy_config.sh
