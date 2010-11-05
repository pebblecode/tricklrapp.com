task "resque:setup" => :environment do

end
require 'resque/tasks'
namespace :tricklr do
  desc "Boots resque-web and starts a local worker"
  task(:boot_resque  => :environment) do
    system("resque-web -p 8282 #{Rails.root}/config/initializers/load_resque.rb")
    ENV['QUEUE'] = '*'
    Rake::Task[ "resque:work &"].invoke
  end
  
end
