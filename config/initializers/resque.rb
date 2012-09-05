require 'resque'
require 'resque_scheduler'
require 'resque/server'

if !Rails.env.development?
  Resque::Server.use Rack::Auth::Basic do |username, password|
    username == 'resque'
    password == 'tU-R4t+EdruX'
  end
end
