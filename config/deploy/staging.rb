# This will pre-compile the Rails 3 Asset Pipeline
# load 'deploy/assets'
server "apu.pebbleit.com", :app, :web, :db, :primary => true
set :deploy_to, "/var/www/vhosts/tricklrapp.com/httpdocs" 
set :branch, "master"
# set :rvm_ruby_string, '1.9.2@tricklr'

namespace :deploy do
  task :start do
    run "/usr/sbin/monit -g tricklr start all"
    run "/etc/init.d/tricklr start"
  end

  task :stop do
    run "/usr/sbin/monit -g tricklr stop all"
    run "/etc/init.d/tricklr stop"
  end

  task :restart do
    run "/usr/sbin/monit -g tricklr restart all"
    run "/etc/init.d/tricklr restart"
  end

  task :link_config_files do
    run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{deploy_to}/#{shared_dir}/tmp/sockets #{release_path}/tmp/sockets"
  end
end

after "deploy:update_code", "deploy:link_config_files"

