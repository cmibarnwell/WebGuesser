require 'sinatra'
require 'sinatra/reloader'

class Guess
  @@count = 5
  #Create our secret number
  @@num = rand(1..100)
  def self.get_count
    return @@count
  end
  def self.get_num
    return @@num
  end
  def self.countSubtract
    @@count -= 1
  end
  def self.countReset
    @@count = 5
  end
  def self.newNum
    @@num = rand(1..100)
  end
end

get '/' do

  #Gather our guess value and convert it to an integer
  guess = params["guess"].to_i

  #Check secret number against guess value and generate response
  msg = checkGuess(guess)

  #Call our index with parameters
  num = Guess.get_num
  count = Guess.get_count
  erb :index, :locals => {:num => num, :msg => msg, :count  => count}
end


def checkGuess(guess)
  if guess == 0
    msg = ""
    return msg
  elsif (Guess.get_num+5) >= guess && guess > Guess.get_num
    msg = "Too high!"
  elsif (Guess.get_num-5) <= guess && guess < Guess.get_num
    msg = "Too low!"
  elsif guess > (Guess.get_num + 5)
    msg = "Way too high!"
  elsif guess < (Guess.get_num - 5)
    msg = "Way too low!"
  else
    msg = "You got it right! A new number has been generated if you'd like to play again."
    Guess.newNum
    Guess.countReset
    return msg
  end

  Guess.countSubtract

  if Guess.get_count == 0
    temp = Guess.get_num
    Guess.newNum
    Guess.countReset
    return "No more guesses! Try again. A new number has been generated. Number was #{temp}"
  end

  return msg
end