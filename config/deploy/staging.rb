server "apu.pebbleit.com", :app, :web, :db, :primary => true
set(:deploy_to) { "/var/www/vhosts/tricklrapp.com/httpdocs" }
set :branch, "master"

namespace :deploy do
  task :start do
    sudo "#{sudo} /usr/bin/monit -g #{application} start all"
  end

  task :stop do
    sudo "/usr/bin/monit -g #{application} stop all"
  end

  task :restart do
    sudo "/usr/bin/monit -g #{application} restart all"
  end
end

