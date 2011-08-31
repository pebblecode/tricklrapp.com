resque_scheduler: bundle exec rake resque:scheduler
resque_web: bundle exec resque-web --foreground --server thin --port $PORT --no-launch
worker: bundle exec rake environment resque:work QUEUE=*
