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


#
# # my notes above
#
# gavins notes below
#

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

# hello world home page
get '/' do
  json ["hello", "world"]
end

# get one joke useing a differne param method
# /joke?number=3
#
get '/joke' do
  # params is a variable (secret, it is really a method...)
  # that is a hash
  #
  # I can lookup a parameter and get it's value

  # Lookup the URL parameter called 'number' and turn this into an integer
  number = params["number"].to_i

  json        joke: JOKES[number]
end

# get all jokes 
get '/jokes' do

  # order(:id) orders everything by the id number
  all_jokes = Joke.all.order(:id)

  json    jokes: all_jokes
end

#get one joke by 
get '/jokes/:id' do

  joke_from_database = Joke.find(params["id"])

  json   joke: joke_from_database

  # json({ joke: JOKES[id] })
  #
  # More minimal syntax below
  #json joke: JOKES[id]
end


#creating a joke
#
post '/jokes' do


# p data
data = JSON.parse(request.body.read)

  # p params
  joke_params = data["joke"]

# manual create looks like
# Joke.create(  punchline: "joke here")
new_joke = Joke.create(joke_params)

json joke: new_joke
end

# updating a joke
put '/jokes/:id' do
  data = JSON.parse(request.body.read)
  joke_params = data["joke"]

  existing_joke = Joke.find(params["id"])

  existing_joke.update(joke_params)

  json joke: existing_joke
end

# delete one joke 
delete '/jokes/:id' do
deleting_joke =Joke.find(params["id"])

deleting_joke.destroy

json joke: deleting_joke
end

#
# # gavins notes edited to mine above
#
# gavins notes below
#


