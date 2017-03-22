require 'sinatra'
require 'sinatra/reloader'

#Create our secret number
num = rand(100)

get '/' do
  #Gather our guess value and convert it to an integer
  guess = params["guess"].to_i
  #Check secret number against guess value and generate response
  msg = checkGuess(guess, num)
  #Call our index with parameters
  erb :index, :locals => {:num => num, :msg => msg}
end


def checkGuess(guess, num)
  if (num+5) >= guess && guess > num
    msg = "Too high!"
  elsif (num-5) <= guess && guess < num
    msg = "Too low!"
  elsif guess > (num + 5)
    msg = "Way too high!"
  elsif guess < (num - 5)
    msg = "Way too low!"
  else
    msg = "You got it right!"
  end
  return msg
end