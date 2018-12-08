require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    @bundle_url = get_bundle_url
    erb :welcome
  end

  get "/hello" do
    @bundle_url = get_bundle_url
    @api_url = api_url(service='hello')

    erb :hello
  end

  post "/hello" do
    @bundle_url = get_bundle_url

    begin
      response = HTTParty.get(api_url(service='hello'))
      @hello = JSON.parse(response.body)['message']
    rescue HTTParty::Error => error
      puts error.inspect
      raise error
    end

    erb :hello
  end

  get '/api/hello' do
    content_type :json
    headers 'Access-Control-Allow-Origin' => '*'
    { :message => 'Hello World!' }.to_json
  end

  helpers do
    def get_bundle_url
      "main.bundle.js"
    end

    def api_url(service)
      "#{ENV['API_URL']}/#{service}"
    end

    def action_url(action)
      if ENV['SINATRA_ENV'] == 'lambda'
        "/Prod/#{action}"
      else
        "/#{action}"
      end
    end
  end

end
