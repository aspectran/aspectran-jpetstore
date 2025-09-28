#!/bin/sh
# Pulls the latest source and deploys configuration and webapps files.

set -e

./1-pull.sh
./3-deploy_config.sh
./4-deploy_webapps.sh
