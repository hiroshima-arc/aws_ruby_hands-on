if ENV['SINATRA_ENV'] == 'lambda'
  require 'httparty'
  require 'json'
  ENV['BUNDLE_URL'] = 'https://s3.amazonaws.com/ruby-hands-on'
else
  ENV['SINATRA_ENV'] ||= "development"
  ENV['API_URL'] ||= 'http://127.0.0.1:9393/api'

  require 'bundler/setup'
  Bundler.require(:default, ENV['SINATRA_ENV'])

  ActiveRecord::Base.establish_connection(
      :adapter => "sqlite3",
      :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
  )

  Aws.config.update({
                        credentials: Aws::Credentials.new(
                            ENV["AWS_ACCESS_KEY_ID"],
                            ENV["AWS_SECRET_ACCESS_KEY"]
                        )
                    })
  Aws.config.update({region: ENV["AWS_DEFAULT_REGION"]})
  Aws.config.update({endpoint: 'http://localhost:8000'})

  require './app/controllers/application_controller'
  require_all 'app'
end