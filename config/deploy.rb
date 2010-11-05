require 'capistrano/ext/multistage'
require 'bundler/capistrano'

set :stages, %w(production staging)
  
set :keep_releases, 3 
set :repository,  "git@apu.pebbleit.com:tweethopper.com.git"
set :use_sudo, false
set :scm, :git
set :deploy_via, :remote_cache
set :application, "tricklr"

set :default_stage, "staging"
 
# source: http://tomcopeland.blogs.com/juniordeveloper/2008/05/mod_rails-and-c.html
namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
 
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
  desc "invoke the db migration"
  task:migrate, :roles => :app do
    send(run_method, "cd #{current_path} && rake db:migrate RAILS_ENV=#{stage} ")     
  end
  
  desc "Link in the production database.yml" 
  task :link_config_files do
    run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml"
  end
  
end

after "deploy:update_code", "deploy:link_config_files"



#Dir[File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'hoptoad_notifier-*')].each do |vendored_notifier|
#  $: << File.join(vendored_notifier, 'lib')
#end

# require 'hoptoad_notifier/capistrano'


