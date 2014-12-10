web: bundle exec rackup config.ru -p $PORT
worker_default: bundle exec sidekiq -c 2 -q default -r ./workers.rb
worker_failing: bundle exec sidekiq -c 2 -q failing -r ./workers.rb
