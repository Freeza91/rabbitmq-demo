class ApplicationController < MyApp

  helpers ApplicationHelper

  get  '/' do
    p $channel
    p $queue
    p $redis
    json hello: settings.foo
  end

end