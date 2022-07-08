require_relative './lib/game'
require_relative './lib/string_color_utils'

PLAYER_BREAKER = '1'
PLAYER_MASTER = '2'

def player_breaker_game_loop
  game = Game.new
  until game.over?
    game.print_state
    guess = gets.chomp
    game.make_guess(guess)
  end

  if game.won?
    puts 'Congratulations! You guessed the code!'.green
  else
    puts 'Opps! you ran out of chances!'
  end

  game.conclude
end

def player_master_game_loop

  puts 'Enter a 4 digit number where each digit is in the range
  [0,5] inclusive'
  code = gets.chomp
  game = Game.new
  game.code = code

  until game.over?
    game.print_state
    guess = Array.new(4) { rand(6) }.join("")
    game.make_guess(guess)
    sleep(1)
  end
  game.print_state

  if game.won?
    puts 'The computer guessed the code!'.red
  else
    puts 'The Computer did not guess the code!'.green
  end

  game.conclude

end

puts 'Try to guess the code in less than 12 attempts!
The code is 4 digits long. To guess, type a number
consisting of 4 digits, where each digit is in the
range [0,5] inclusive. Each digit corresponds to
a seperate color'

puts "[#{PLAYER_BREAKER}] Enter #{PLAYER_BREAKER} to play as the code breaker"
puts "[#{PLAYER_MASTER}] Enter #{PLAYER_MASTER} to play as the code master"

# Player chooses whether to play as code breaker
# or code master. The player must choose either
# of the two.
choice = gets.chomp
until '12'.include? choice
  puts 'Please Enter either 1 or 2'
  choice = gets.chomp
end

case choice
when PLAYER_BREAKER
  player_breaker_game_loop
when PLAYER_MASTER
  player_master_game_loop
end
