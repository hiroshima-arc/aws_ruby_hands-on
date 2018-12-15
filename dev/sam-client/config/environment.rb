if ENV['SINATRA_ENV'] == 'lambda'
  require 'httparty'
  require 'json'
  require 'aws-record'
  require 'active_record'
  require 'require_all'

  ENV['BUNDLE_URL'] = 'https://s3.amazonaws.com/ruby-hands-on'

  require_all 'app', 'db/migrate'
  DynamoDB::CreateMovies.migrate
else
  ENV['SINATRA_ENV'] ||= "development"
  ENV['API_URL'] ||= 'http://127.0.0.1:9393/api'
  ENV["AWS_DEFAULT_REGION"] ||= 'us-east-1'
  ENV["DB_ENDPOINT"] ||= 'http://localhost:8000'

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
  Aws.config.update({endpoint: ENV["DB_ENDPOINT"]})

  require './app/controllers/application_controller'
  require_all 'app'
end