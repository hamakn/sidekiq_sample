require "sinatra"
require "redis"
require "sidekiq"
require "./workers"

Sidekiq.configure_client do |config|
  config.redis = { size: 1 }
end

get '/' do
  erb :index
end

post '/' do
  Worker.perform_async(params)
  redirect "/"
end

post '/failing' do
  FailingWorker.perform_async(params)
  redirect "/"
end

__END__

@@ index
<html>
  <head><title>Sidekiq Demo</title></head>
  <body>
    <p>
      <a href="/sidekiq">sidekiq web</a>
    </p>
    <form method="POST">
      <input type="submit" value="Create New Job"/>
    </form>

    <form action='/failing' method='POST'>
      <input type="submit" value="Create Failing New Job"/>
    </form>
  </body>
</html>
