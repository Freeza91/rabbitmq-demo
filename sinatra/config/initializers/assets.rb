MyApp.configure do |app|
  app.set :assets_prefix, %w(app/assets vendor/assets)
  app.set :assets_css_compressor, :sass
  app.set :assets_js_compressor, :uglifier
end
