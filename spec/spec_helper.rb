ENV["RAILS_ENV"] ||= 'test'
require 'rubygems'
require 'spork'
require 'resque_spec/scheduler'

Spork.prefork do
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  # From http://github.com/timcharper/spork/wiki/Spork.trap_method-Jujutsu
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)
  
  require 'capybara/rspec'
  require 'shoulda/integrations/rspec2'
  require 'shoulda'
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
  
  RSpec.configure do |config|
    config.mock_with :rspec
    config.include Devise::TestHelpers, :type => :controller

    config.use_transactional_fixtures = true

    # From http://railscasts.com/episodes/285-spork
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true    
  end

  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:twitter, { 
    :provider    => "twitter", 
    :uid         => "36670724", 
    :info   => { 
    :name       => "George Ornbo", 
    :nickname   => "shapeshed"
  }, 
    :credentials => {   
    :token => "36670724-itwLyz641g76JitN9CTIpEw5Dtrsa7NLU7fpZ7aPXO",
    :secret => "OcKQ907H0KUV7qzbWNGNYasdEBDsjasd5rPXtyTzi6c"
  } 
  })
  
end

Spork.each_run do
end
