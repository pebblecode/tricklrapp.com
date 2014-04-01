# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role
role :app, %w{deploy@example.com}
role :web, %w{deploy@example.com}
role :db,  %w{deploy@example.com}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server 'example.com', user: 'deploy', roles: %w{web app}, my_property: :my_value

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


# This will pre-compile the Rails 3 Asset Pipeline
# load 'deploy/assets'
# server "starling.tricklrapp.com", :app, :web, :db, :primary => true
# set :deploy_to, "/srv/tricklrapp.com"
# set :branch, "production"
# set :user, "tricklr"
# # If anything fails during a deploy and you want to see the trace:
# # set :rake, "#{rake} --trace"
# set :default_environment, {
#   'PATH' => "/home/tricklr/.rbenv/shims:/home/tricklr/.rbenv/bin:$PATH"
# }

# namespace :deploy do
#   task :start do
#     sudo "/usr/sbin/monit -g tricklr start all"
#     run "/etc/init.d/tricklr start"
#   end

#   task :stop do
#     sudo "/usr/sbin/monit -g tricklr stop all"
#     run "/etc/init.d/tricklr stop"
#   end

#   task :restart do
#     sudo "/usr/sbin/monit -g tricklr restart all"
#     run "/etc/init.d/tricklr upgrade"
#   end

#   task :link_config_files do
#     run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml"
#     run "ln -nfs #{deploy_to}/#{shared_dir}/tmp/sockets #{release_path}/tmp/sockets"
#     run "ln -nfs #{shared_path}/config/unicorn.rb #{release_path}/config/unicorn.rb"
#   end

# end

# before "deploy:assets:precompile", "deploy:link_config_files"