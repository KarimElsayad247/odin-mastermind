require_relative './lib/game.rb'
require_relative './lib/string_color_utils'

game = Game.new

puts 'Try to guess the code in less than 12 attempts! 
      The code is 4 digits long. To guess, type a number 
      consisting of 4 digits, where each digit is in the
      range [0,5] inclusive. Each digit corresponds to
      a seperate color'

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

