ENV["RAILS_ENV"] ||= 'test'
require 'rubygems'
require 'spork'

Spork.prefork do
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'capybara/rspec'
  require 'shoulda/integrations/rspec2'
  require 'shoulda'
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
end

Spork.each_run do
end


RSpec.configure do |config|
  config.mock_with :rspec
  config.include Devise::TestHelpers, :type => :controller

  config.use_transactional_fixtures = true
end

OmniAuth.config.test_mode = true
OmniAuth.config.add_mock(:twitter, { 
  :provider    => "twitter", 
  :uid         => "36670724", 
  :user_info   => { 
  :name       => "George Ornbo", 
  :nickname   => "shapeshed"
}, 
  :credentials => {   
  :token => "36670724-itwLyz641g76JitN9CTIpEw5Dtrsa7NLU7fpZ7aPXO",
  :secret => "OcKQ907H0KUV7qzbWNGNYasdEBDsjasd5rPXtyTzi6c"
} 
})
