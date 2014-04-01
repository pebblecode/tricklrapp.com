# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role
role :app, %w{tricklrapp.com}
role :web, %w{tricklrapp.com}
role :db, %w{tricklrapp.com}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server 'apu.pebblecode.net', user: 'webapps', roles: %w{web app db}, primary: true

# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
# and/or per server
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
# setting per server overrides global ssh_options

# server "apu.pebblecode.net", :app, :web, :db, :primary => true
set :deploy_to, "/srv/http/pebblecode.net/subdomains/tricklrapp"
# set :branch, "master"
# set :user, "webapps"
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

  # task :link_config_files do
  #   run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml"
  #   run "ln -nfs #{deploy_to}/#{shared_dir}/tmp/sockets #{release_path}/tmp/sockets"
  # end
end

# before "deploy:assets:precompile", "deploy:link_config_files"
