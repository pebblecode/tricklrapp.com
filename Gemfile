source 'http://rubygems.org'

gem 'rails', '3.2.8'

# Postgres
# https://bitbucket.org/ged/ruby-pg/wiki/Home
gem 'pg'

# Devise for Authentication layer
# http://github.com/plataformatec/devise
gem 'devise'

# Omniauth for easy authentication against third parties
# https://github.com/intridea/omniauth
gem 'omniauth-twitter'

# Not used right now
# Will paginate for pagination
# https://github.com/mislav/will_paginate/wiki
# gem 'will_paginate', '~> 3.0'

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

# Automates using jQuery with Rails3
# https://github.com/indirect/jquery-rails
gem 'jquery-rails'

# https://github.com/thoughtbot/hoptoad_notifier
gem 'hoptoad_notifier'

# Performance monitoring with NewRelic
gem 'newrelic_rpm'

# Send stats to Campfire
gem 'tinder'

group :test do
  gem 'random_data'
  gem 'capybara'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'rspec-rails'
  gem 'resque_spec'
  gem "factory_girl_rails", "~> 4.0"
  gem 'spork', '~> 0.9.0.rc'
  gem 'guard-cucumber'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'ruby-debug19'
end

group :development do
  gem 'sqlite3-ruby'
  gem 'mysql2'
  gem 'thin'
  gem 'unicorn'
  gem 'capistrano'
  gem 'capistrano-ext'
  gem 'rb-fsevent'
  gem 'growl'
  gem 'foreman'
  gem 'ruby-debug19'
end

group :production do
  gem 'unicorn'
  gem 'thin'
  gem 'therubyracer'
end

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'compass-rails'
end
