#!/bin/sh
# Pulls the latest source, builds the application, and deploys all components.

set -e

./1-pull.sh
./2-build.sh
./3-deploy_config.sh
./4-deploy_webapps.sh
