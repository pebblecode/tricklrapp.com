require 'resque'
require 'resque_scheduler'
Resque.redis.namespace = "resque:Tricklr"
