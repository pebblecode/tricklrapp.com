ENV["RAILS_ENV"] ||= 'test'
require 'rubygems'
require 'spork'

Spork.prefork do
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
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
