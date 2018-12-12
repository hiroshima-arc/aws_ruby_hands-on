file = File.read('db/moviedata.json')
movies = JSON.parse(file)

puts 'Start'
state = '.'
movies.each do |movie|
  state += '.'
  Movie.new(movie).save!
  print state
end
puts 'Done!'