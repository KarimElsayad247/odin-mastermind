require './lib/game.rb'

game = Game.new()

loop do
  game.print_state
  guess = gets.chomp
  game.make_guess(guess)
end
