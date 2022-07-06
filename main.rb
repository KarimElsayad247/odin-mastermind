require_relative './lib/game.rb'
require_relative './lib/string_color_utils'

PLAYER_BREAKER = "1"
PLAYER_MASTER = "2"


def player_breaker_game_loop
  puts 'Try to guess the code in less than 12 attempts! 
The code is 4 digits long. To guess, type a number 
consisting of 4 digits, where each digit is in the
range [0,5] inclusive. Each digit corresponds to
a seperate color'
  
  game = Game.new
  until game.over?
    game.print_state
    guess = gets.chomp
    game.make_guess(guess)
  end
  
  if game.won?
    puts "Congratulations! You guessed the code!".green
  else
    puts "Opps! you ran out of chances!"
  end
  
  game.conclude
end  

def player_master_game_loop

end

puts "[#{PLAYER_BREAKER}] Enter #{PLAYER_BREAKER} to play as the code breaker"
puts "[#{PLAYER_MASTER}] Enter #{PLAYER_MASTER} to play as the code master"
   
# Player chooses whether to play as code breaker 
# or code master. The player must choose either
# of the two.
choice = gets.chomp
until "12".include? choice
  puts "Please Enter either 1 or 2"
  choice = gets.chomp
end

if choice == PLAYER_BREAKER
  player_breaker_game_loop()
elsif choice == PLAYER_MASTER
  player_master_game_loop()
end