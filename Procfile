resque: env TERM_CHILD=1 bundle exec rake resque:work
resque: env TERM_CHILD=1 RESQUE_TERM_TIMEOUT=7 bundle 
exec rake resque:work
QUEUE=mailer rake environment resque:work