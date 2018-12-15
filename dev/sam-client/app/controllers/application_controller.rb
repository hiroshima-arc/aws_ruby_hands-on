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

  get "/movie" do
    @bundle_url = get_bundle_url
    @movie = 'Ready...'
    erb :movie
  end

  post "/movie/new" do
    @bundle_url = get_bundle_url
    @params.each { |k,v| redirect '/movie' if v.empty? }

    begin
      response = HTTParty.post(
          api_url(service='movie/new'),
          :body => @params,
          :header => { 'Content-Type' => 'application/json' }
      )
      @movie = JSON.parse(response.body)['message']
    rescue HTTParty::Error => error
      puts error.inspect
      raise error
    end

    erb :movie
  end

  post '/api/movie/new' do
    content_type :json
    headers 'Access-Control-Allow-Origin' => '*'

    begin
      year = params[:year]
      title = params[:title]
      plot = params[:info][:plot]
      rating = params[:info][:rating]

      movie = Movie.find(year: year, title: title)

      if movie.nil?
        movie = Movie.new(
            year: year,
            title: title,
            info: {
                plot: plot,
                rating: rating
            })
        movie.save!

        { :message => 'Success' }.to_json
      else
        { :message => 'There is record' }.to_json
      end
    rescue => e
      puts e.inspect
      raise e
    end
  end

  get '/api/movie' do
    content_type :json
    headers 'Access-Control-Allow-Origin' => '*'
    result = Movie.find(
        year: 2015,
        title: 'The Big New Movie'
    )

    (JSON.parse(result.to_json)['data']['data']).to_json unless result.nil?
  end

  get '/api/movie/update' do
    movie = Movie.find(year: 2015, title: 'The Big New Movie')
    movie.info['rating'] += 1
    movie.save!
  end

  get '/api/movie/delete' do
    movie = Movie.new(year: 2015, title: 'The Big New Movie')
    movie.delete!
  end

  get '/api/movie/query/1' do
    content_type :json
    headers 'Access-Control-Allow-Origin' => '*'

    movies = Movie.query(
        key_condition_expression: '#yr = :yyyy',
        expression_attribute_names: { '#yr' => 'year'},
        expression_attribute_values: { ':yyyy' => 1985 }
    )

    result = []
    movies.each do |movie|
      result.append({year: movie.year.to_i, title: movie.title})
    end
    result.to_json
  end

  get '/api/movie/query/2' do
    content_type :json
    headers 'Access-Control-Allow-Origin' => '*'

    movies = Movie.query(
        projection_expression: '#yr, title, info.genres, info.actors[0]',
        key_condition_expression: '#yr = :yyyy and title between :letter1 and :letter2',
        expression_attribute_names: { '#yr' => 'year' },
        expression_attribute_values: { ':yyyy' => 1992, ':letter1' => 'A', ':letter2' => 'L' }
    )

    result = []
    movies.each do |movie|
      result.append({year: movie.year.to_i, title: movie.title, actors: movie.info['actors']})
    end
    result.to_json
  end

  get '/api/movie/query/3' do
    content_type :json
    headers 'Access-Control-Allow-Origin' => '*'

    movies = Movie.scan(
        projection_expression: "#yr, title, info.rating",
        filter_expression: "#yr between :start_yr and :end_yr",
        expression_attribute_names: {"#yr"=> "year"},
        expression_attribute_values: {
            ":start_yr" => 1950,
            ":end_yr" => 1959
        }
    )

    result = []
    movies.each do |movie|
      result.append({year: movie.year.to_i, title: movie.title, actors: movie.info['rating']})
    end
    result.to_json
  end

  helpers do
    def get_bundle_url
      "#{ENV['BUNDLE_URL']}/main.bundle.js"
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
