require 'resque/tasks'
require 'resque/scheduler/tasks'
#task "resque:setup" => :environment 
namespace :resque do
    task :setup do
        require 'resque'
        require 'resque-scheduler'
        require 'resque/scheduler'

        Resque.redis = 'localhost:6379'
        Resque::Scheduler.dynamic = true
        # Resque.schedule = YAML.load_file(File.join(Rails.root, 'config/twitter_profiles_downloader_schedule.yml'))  
    end
end
