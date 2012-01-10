#---------------------------
# Multistage support for Capistrano
#---------------------------
require 'capistrano/ext/multistage'

#---------------------------
# Define Capistrano stages
#---------------------------
set :stages, %w(production staging)
set :default_stage, "staging"

#---------------------------
# We are using bundler so let Capistrano know
#---------------------------
require 'bundler/capistrano'
  
set :normalize_asset_timestamps, false

#---------------------------
# Git stuff
#---------------------------
set :repository,  "git@github.com:pebblecode/tricklrapp.com.git"
set :scm, :git
set :deploy_via, :remote_cache
set :keep_releases, 3 
default_run_options[:pty] = true


require 'hoptoad_notifier/capistrano'
