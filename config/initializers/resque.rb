require 'resque'
require 'resque_scheduler'

if !Rails.env.development?
  Resque::Server.use Rack::Auth::Basic do |username, password|
    username == 'resque'
    password == 'tU-R4t+EdruX'
  end
end
