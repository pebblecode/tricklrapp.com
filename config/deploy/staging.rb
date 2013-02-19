# This will pre-compile the Rails 3 Asset Pipeline
load 'deploy/assets'
server "apu.pebblecode.net", :app, :web, :db, :primary => true
set :deploy_to, "/srv/http/pebblecode.net/subdomains/tricklrapp"
set :branch, "master"
set :user, "webapps"
set :default_environment, {
  'PATH' => "/home/webapps/.rbenv/shims:/home/webapps/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
}

set :pid, "#{deploy_to}/shared/pids/unicorn.pid"
set :start_command, "cd #{current_path} && bundle exec unicorn -D -E production -c #{current_path}/config/unicorn.rb"


namespace :deploy do
  task :start do
    run start_command
  end

  task :stop do
    run "test -f #{pid} && kill `cat #{pid}`"
  end

  task :restart do
    run "test -f #{pid} && kill `cat #{pid}`"
    run start_command
  end

  task :link_config_files do
    run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{deploy_to}/#{shared_dir}/tmp/sockets #{release_path}/tmp/sockets"
  end
end

before "deploy:assets:precompile", "deploy:link_config_files"

