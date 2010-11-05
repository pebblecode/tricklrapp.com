server "apu.pebbleit.com", :app, :web, :db, :primary => true
set(:deploy_to) { "/var/www/vhosts/tricklrapp.com/httpdocs" }
set :branch, "master"

