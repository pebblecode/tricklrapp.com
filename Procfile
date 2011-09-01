resque_scheduler: bundle exec rake resque:scheduler
resque_web: bundle exec resque-web config/initializers/load_resque.rb --foreground --server thin --port $PORT --no-launch
worker: bundle exec rake environment resque:work QUEUE=*
