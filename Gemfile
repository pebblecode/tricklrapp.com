source 'http://rubygems.org'

gem 'rails', '3.2.12'

# Postgres
# https://bitbucket.org/ged/ruby-pg/wiki/Home
gem 'pg', '0.14.1'

# Devise for Authentication layer
# http://github.com/plataformatec/devise
gem 'devise', '2.1.2'

# Omniauth for easy authentication against third parties
# https://github.com/intridea/omniauth
gem 'omniauth-twitter', '0.0.17'

# Not used right now
# Will paginate for pagination
# https://github.com/mislav/will_paginate/wiki
# gem 'will_paginate', '~> 3.0'

# Twitter gem for reading/writing
# http://github.com/jnunemaker/twitter
gem "twitter", "~> 4.8.1"

# Resque for queuing tasks
gem 'resque', '1.22.0'

# Resque scheduler for scheduled tasks
# http://github.com/bvandenbos/resque-scheduler
gem 'resque-scheduler', '2.0.0'

# Haml for templates
# http://github.com/nex3/haml
gem 'haml', '3.1.7'

# Automates using jQuery with Rails3
# https://github.com/indirect/jquery-rails
gem 'jquery-rails', '2.1.1'

# https://github.com/thoughtbot/hoptoad_notifier
gem 'hoptoad_notifier', '2.4.11'

# Performance monitoring with NewRelic
gem 'newrelic_rpm', '3.4.1'

# Send stats to Campfire
gem 'tinder', '1.9.2'

group :development, :test do
  gem 'debugger', '1.3.1'
  gem 'mocha_rails', '0.0.4'
end

group :test do
  gem 'random_data', '~> 1.5'
  gem 'capybara', '~> 1.1'
  gem 'launchy', '~> 2.1'
  gem 'database_cleaner', '~> 0.8'
  gem 'cucumber-rails', '~> 1.3'
  gem 'rspec-rails', '~> 2.11'
  gem 'resque_spec', '~> 0.12'
  gem "factory_girl_rails", "~> 4.0"
  gem 'spork', '~> 0.9.0.rc'
  gem 'guard-cucumber', '~> 1.2'
  gem 'guard-rspec', '~> 1.2'
  gem 'guard-spork', '~> 1.1'
end

group :development do
  gem 'sqlite3-ruby', '~> 1.3'
  gem 'mysql2', '~> 0.3.11'
  gem 'thin', '~> 1.4.1'
  gem 'unicorn', '~> 4.3.1'
  gem 'capistrano', '~> 3.1.0'
  gem 'capistrano-ext', '~> 1.2.1'
  gem 'rb-fsevent', '~> 0.9.1'
  gem 'growl', '~> 1.0.3'
  gem 'foreman', '~> 0.57.0'
end

group :production do
  gem 'unicorn', '~> 4.3.1'
  gem 'thin', '~> 1.4.1'
  gem 'therubyracer', '~> 0.10.2'
end

group :assets do
  gem 'sass-rails', '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '~> 1.3.0'
  gem 'compass-rails', '~> 1.0.3'
end
