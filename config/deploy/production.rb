# This will pre-compile the Rails 3 Asset Pipeline
load 'deploy/assets'
server "starling.tricklrapp.com", :app, :web, :db, :primary => true
set :deploy_to, "/srv/tricklrapp.com" 
set :branch, "production"
set :user, "tricklr"

set :default_environment, {
  'PATH' => "/home/tricklr/.rbenv/shims:/home/tricklr/.rbenv/bin:$PATH"
}

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

end

before "deploy:assets:precompile", "deploy:link_config_files"

