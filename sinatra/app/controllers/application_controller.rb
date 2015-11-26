class ApplicationController < MyApp

  helpers ApplicationHelper

  get  '/' do
    json hello: settings.foo
  end

end