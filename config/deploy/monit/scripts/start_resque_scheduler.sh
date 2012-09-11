#!/usr/bin/env bash

# -------------------------------- #
# Variables
# -------------------------------- #
USER=tricklr
APP_PATH=/srv/http/pebblecode.net/subdomains/tricklrapp/current
PATH=/home/$USER/.rbenv/bin:/home/$USER/.rbenv/shims:$PATH
RAILS_ENV=production

cd $APP_PATH
RAILS_ENV=$RAILS_ENV rake environment resque:scheduler& > $APP_PATH/log/resque_scheduler.log
echo $! > $APP_PATH/tmp/pids/resque_scheduler.pid
