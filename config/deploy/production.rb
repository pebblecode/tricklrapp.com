# This will pre-compile the Rails 3 Asset Pipeline
# load 'deploy/assets'
server "apu.pebbleit.com", :app, :web, :db, :primary => true
set :deploy_to, "/var/www/vhosts/tricklrapp.com/httpdocs" 
set :branch, "master"
set :rvm_ruby_string, '1.9.2@tricklr'
set :user, "tricklr"

namespace :deploy do
  task :start do
    sudo "/usr/sbin/monit -g tricklr start all"
    sudo "/etc/init.d/tricklr start"
  end

  task :stop do
    sudo "/usr/sbin/monit -g tricklr stop all"
    sudo "/etc/init.d/tricklr stop"
  end

  task :restart do
    sudo "/usr/sbin/monit -g tricklr restart all"
    sudo "/etc/init.d/tricklr upgrade"
  end

  task :link_config_files do
    run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{deploy_to}/#{shared_dir}/tmp/sockets #{release_path}/tmp/sockets"
  end

  desc "Precompiles assets for the Asset Pipeline"
  task :precompile_assets do
    run "cd #{current_path} && bundle exec rake RAILS_ENV=production RAILS_GROUPS=assets assets:precompile"
  end

end

after "deploy:update_code", "deploy:link_config_files", "deploy:precompile_assets"

