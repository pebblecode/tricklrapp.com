source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Postgres
# https://bitbucket.org/ged/ruby-pg/wiki/Home
gem 'pg'


# MySql2 
gem 'mysql2'

# Sqlite
gem 'sqlite3-ruby'


# Devise for Authentication layer
# http://github.com/plataformatec/devise
gem 'devise'

# Omniauth for easy authentication against third parties
# https://github.com/intridea/omniauth
gem "oa-oauth", :require => 'omniauth/oauth'

# Will paginate for pagination
# https://github.com/mislav/will_paginate/wiki
gem 'will_paginate', '~> 3.0.pre2'

# Twitter gem for reading/writing
# http://github.com/jnunemaker/twitter
gem 'twitter'

# Resque for queuing tasks
gem 'resque'

# Resque scheduler for scheduled tasks
# http://github.com/bvandenbos/resque-scheduler
gem 'resque-scheduler'

# Haml for templates
# http://github.com/nex3/haml
gem 'haml'

# Compass for CSS 
# https://github.com/chriseppstein/compass
gem 'compass'

# Automates using jQuery with Rails3
# https://github.com/indirect/jquery-rails
gem 'jquery-rails'

# https://github.com/thoughtbot/hoptoad_notifier
gem 'hoptoad_notifier'

# Performance monitoring with NewRelic
gem 'newrelic_rpm'

# Rails 3.1 - Asset Pipeline
gem 'sass-rails', '~> 3.1.0'
gem 'coffee-rails', '~> 3.1.0'
gem 'uglifier'


group :test do
  gem 'shoulda'
  gem 'random_data'
  gem 'capybara'   
  gem 'launchy'
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'rspec-rails'
  gem 'resque_spec'
  gem 'factory_girl_rails'
  gem 'spork', '~> 0.9.0.rc'
  gem 'guard-cucumber'
  gem 'guard-rspec'
  gem 'guard-spork'
end

group :development do
  gem 'thin'
  gem 'unicorn'
  gem 'capistrano'
  gem 'capistrano-ext'
  gem 'rb-fsevent'
  gem 'growl'
  gem 'foreman'
end

group :production do
  gem 'unicorn'
  gem 'thin'
  gem 'therubyracer' 
end 
