# require 'sinatra'
# require 'sinatra/reloader' if development?
# require 'sinatra/json'

# ActiveRecord::Base.establish_connection(
#   adapter: "postgresql",
#   database: "jokes"
# )


# JOKES = [
#   "Why do programmers always mix up Halloween and Christmas?  Because Oct 31 equals Dec 25.",
#   "How many programmers does it take to change a light bulb?  None – It’s a hardware problem",
#   "There are only 10 kinds of people in this world: those who know binary and those who don’t.",
#   "Did you hear about the restaurant on the moon? Great food, no atmosphere.",
#   "What do you call a fake noodle? An Impasta.",
#   "How many apples grow on a tree? All of them.",
#   "Want to hear a joke about paper? Nevermind it's tearable."
# ]

# get '/joke' do
#   number = params["number"].to_i

#   json joke: JOKES[number]
# end




# # similar to route
# # notice we are  using get here
# # now using json, first API (YAAY!)
# get '/' do
#  json ["Hello, World"]
# end

# get '/tacos' do 
# 'mmmm, tacos'
# end

# get '/joke' do
#   # params is a variable (secret, its a method)
#   # that is a has
#   # 
#   # I can lookup a parameter and get its value

#   # lookup the URL parameter called 'number'
#   number = params ["number"].to_i
#   json joke: JOKES[number]
# end


# get '/joke/:id' do
# id = params["id"].to_i
# # json joke: JOKES[id]
# end
#  #lost me at inserting joke into database
#  # 11:57
# # my notes above

# gavins notes below

require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/json'
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "jokes"
)

class Joke < ActiveRecord::Base
end


get '/' do
  json ["hello", "world"]
end

get '/joke' do
  # params is a variable (secret, it is really a method...)
  # that is a hash
  #
  # I can lookup a parameter and get it's value

  # Lookup the URL parameter called 'number' and turn this into an integer
  number = params["number"].to_i

  json        joke: JOKES[number]
end

get '/jokes' do
  all_jokes = Joke.all

  json    jokes: all_jokes
end

get '/jokes/:id' do

  joke_from_database = Joke.find(params["id"])

  json   joke: joke_from_database

  # json({ joke: JOKES[id] })
  #
  # More minimal syntax below
  #json joke: JOKES[id]
end

