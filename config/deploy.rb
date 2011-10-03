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
  
#---------------------------
# We are using rvm so let Capistrano know
# See http://beginrescueend.com/integration/capistrano/
#---------------------------
$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) 
require "rvm/capistrano"
set :rvm_ruby_string, '1.9.2@tricklr'

#---------------------------
# Git stuff
#---------------------------
set :repository,  "git@apu.pebbleit.com:tricklrapp.com.git"
set :scm, :git
set :deploy_via, :remote_cache
set :keep_releases, 3 
default_run_options[:pty] = true


require 'hoptoad_notifier/capistrano'
