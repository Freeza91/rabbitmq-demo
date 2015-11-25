MyApp.configure do |app|
  # app.enable :sessions
  app.set :session_secret, app.settings.secret
  app.set :sessions, true
  # app.use Rack::Session::Cookie, :key => 'rack.session',
  #                                :expire_after => 2592000, # In seconds
  #                                :secret => 'change_me'
end