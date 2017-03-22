require 'sinatra'
require 'sinatra/reloader'

num = rand(100)

get '/' do
  "Randomly Generated Number: #{num}"
end