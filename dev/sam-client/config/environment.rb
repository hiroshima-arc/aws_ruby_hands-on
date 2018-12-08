if ENV['SINATRA_ENV'] == 'lambda'
  require 'httparty'
  require 'json'
else
  ENV['SINATRA_ENV'] ||= "development"
  ENV['API_URL'] ||= 'http://127.0.0.1:9393/api'

  require 'bundler/setup'
  Bundler.require(:default, ENV['SINATRA_ENV'])

  ActiveRecord::Base.establish_connection(
      :adapter => "sqlite3",
      :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
  )

  require './app/controllers/application_controller'
  require_all 'app'
end