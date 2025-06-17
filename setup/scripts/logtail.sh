#!/bin/sh

. ./app.conf

tail -f "$DEPLOY_DIR/logs/$1.log"
