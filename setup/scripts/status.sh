#!/bin/sh

. ./app.conf

sudo systemctl status $APP_NAME
