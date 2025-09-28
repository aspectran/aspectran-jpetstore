#!/bin/sh
# Pulls the latest source and deploys config/webroot components without building.

set -e

./1-pull.sh
./3-deploy_config.sh
./4-deploy_webapps.sh
