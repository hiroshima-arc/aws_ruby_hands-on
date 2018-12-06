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

  helpers do
    def get_bundle_url
      "main.bundle.js"
    end
  end

end
