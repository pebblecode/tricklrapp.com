task "resque:setup" => :environment do

end
require 'resque/tasks'
namespace :tricklr do
  desc "Boots resque-web and starts a local worker"
  task(:bootstrap  => :environment) do
    system("resque-web -p 8282 #{Rails.root}/config/initializers/load_resque.rb")
    system("QUEUE=* rake resque:work &")
    system("rake resque:scheduler &") 
  end
  
end
