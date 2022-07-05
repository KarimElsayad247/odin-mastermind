require_relative 'string_color_utils'

# Represents game state, and contains functions that modifes game state.
class Game
  # How many times a player can still try i.e, number of rows on baord
  INITIAL_CHANCES = 12

  # How long the code is i.e, how many holes for each row of the board
  CODE_LEN = 4

  # How many colors the head can be i.e, the numbers in the code array
  # will be in the range [0..COLORS_COUNT]
  COLORS_COUNT = 6

  def initialize
    @code = Array.new(CODE_LEN) { rand(COLORS_COUNT) }
    @remaining_chances = INITIAL_CHANCES
    @guesses = @code.map do |_number|
      {
        color: false,
        position: false
      }
    end
  end

  # Show the state of the game to the player in a nice, descriptive manner
  # showing how well the player is doing, and how many chances remain+
  def print_state
    # Number of guesses correct in both color (digit) and position
    num_correct_guesses = @guesses.count { |guess| guess[:color] && guess[:position] }

    # Number of guesses correct in color only. It does not include guesses correct
    # in position too.
    num_close_guesses = @guesses.count { |guess| guess[:color] && !guess[:position] }

    @guesses.map { |guess| get_representation(guess) }.each { |x| print " #{x} " }
    puts ''
    puts "#{num_correct_guesses} guesses correct in color and position".green
    puts "#{num_close_guesses} guesses correct in color, but not position".brown
    puts "Current attempt: #{INITIAL_CHANCES - @remaining_chances + 1}/#{INITIAL_CHANCES}"
  end

  def make_guess(guess)
    unless guess.length == @code.length
      puts "Your guess needs to be #{@code.length} digits long!"
      return
    end

    # Restore guesses to initial state before analyzing new guess
    @guesses.each do |guess_object|
      guess_object[:color] = false
      guess_object[:position] = false
    end

    new_guesses = guess.split(//).map(&:to_i)
    position_incorrect = []

    # p "Code: ", @code
    # p "Guess: ", new_guesses

    # Number of guesses correct in both color (digit) and position
    new_guesses.each_with_index do |digit, i|
      if @code[i] == digit
        @guesses[i][:color] = true
        @guesses[i][:position] = true
      else
        position_incorrect << @code[i]
      end
    end

    # p "position incorrect: ", position_incorrect

    # Analyze each guess and check whether it's correct or close.
    new_guesses.each_with_index do |digit, i|
      @guesses[i][:color] = true if position_incorrect.include?(digit)
      @guesses[i][:number] = digit
    end

    @remaining_chances -= 1

    # pp @guesses
  end

  # A game is over when the player either correctly guesses the code,
  # or exahsts all their chances
  def over?
    @remaining_chances.zero? || code_correctly_guessed?
  end

  def won?
    code_correctly_guessed?
  end

  def conclude
    puts 'Code was'
    @code.map { |digit| get_representation(digit) }.each { |x| print " #{x} " }
  end

  private

  def code_correctly_guessed?
    @guesses.all? { |guess| guess[:position] }
  end

  def get_representation(guess)
    if guess[:numbeSr]
      " #{apply_color(guess[:number])} "
    else
      ' _ '.bold
    end
  end

  def apply_color(number)
    output = " #{number} "

    case number
    when 0
      output.bg_black.gray
    when 1
      output.bg_cyan.gray
    when 2
      output.bg_green.gray
    when 3
      output.bg_red.gray
    when 4
      output.bg_magenta.gray
    when 5
      output.bg_brown
    else
      output.bg_red
    end
  end
end
