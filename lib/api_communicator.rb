require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  movies_link = []
  response_hash["results"].each do |film|
    movies_link << film["films"]
  end
   
  

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  new_arr = []
  movies_link.each do |movie_link|
    movie_link.each do |link|
      movie_name = RestClient.get(link)
      name = JSON.parse(movie_name)
      new_arr << {title: name["title"], info: name["opening_crawl"]}
    end
  end
  new_arr
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each do |film|
  puts 
  puts "**********************************************************************"
  puts film[:title]
  puts film[:info]
  # binding.pry
  end
  # binding.pry
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

# movies = get_character_movies_from_api("lukes skywalker")

# print_movies(movies)
show_character_movies("lukes skywalker")