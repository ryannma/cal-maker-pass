require 'resque-scheduler'
require 'resque/job_with_status'
require 'resque/server'
require 'resque/status_server'

Resque.redis = "localhost:6379"
Dir["/app/app/jobs/*.rb"].each { |file| require file }
Resque::Plugins::Status::Hash.expire_in = (24 * 60 * 60)