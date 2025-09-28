#!/bin/sh
# Pulls the latest source and deploys webapps files only.

set -e

./1-pull.sh
./4-deploy_webapps.sh
