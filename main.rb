require_relative './lib/game.rb'
require_relative './lib/string_color_utils'

game = Game.new()


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


