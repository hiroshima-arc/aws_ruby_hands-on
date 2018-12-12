class Movie
  include Aws::Record

  integer_attr :year, hash_key: true
  string_attr :title, range_key: true
  map_attr :info
end