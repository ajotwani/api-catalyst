#*******************************************************************************************
# This code snippet returns Opening Movies using Rotten Tomatoes Opening Movies API
# You will need to get an API key from Crunchbase http://developer.rottentomatoes.com
# Once you have the API key, enter that in the api_config.eb file
#*******************************************************************************************

require 'json'
require 'open-uri'
require_relative 'api_config'

url = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/opening.json?limit=16&country=us&apikey=#{ROTTEN_TOMATOES_API_KEY}"
puts url

begin
   data = JSON.parse(open(url).read)
rescue OpenURI::HTTPError => e #Handling HTTP errors gracefully
  error_code = e.io.status[0]
  print "#{e.message}"
  if error_code == "403" #If invalid API Key - 403
    puts " -- Did you enter your API key in the api_config.rb file?"   
 end
  exit
end

#Grabbing the movies returned into an array
movies = data["movies"]

#iterating through the movies returned and printing the Movie Title
puts "*=" * 20
puts "Showing This Week's Opening Movies"
puts "*=" * 20
movies.each_with_index do |movie,index|
  puts "#{index+1}. #{movie["title"].to_s}"
end