require "sidekiq"

Sidekiq.configure_server do |config|
  config.redis = { size: 1 }
end

class Worker
  include Sidekiq::Worker
  #sidekiq_options queue: :default

  def perform(params)
    sleep 10
    puts "Start perform: class: #{self}, params: #{params}"
    puts "Processed a job!"
  end
end

class FailingWorker
  include Sidekiq::Worker
  sidekiq_options queue: :failing, retry: 1

  def perform(params)
    puts "Start perform: class: #{self}, params: #{params}"
    raise "not processable!"
    puts "Processed a job!"
  end
end
