require_relative 'dictionary'
require_relative 'letter'

class Game
  def initialize
    @guesses_remaining = 7
    @word = get_word
    @letters = @word.split(//)
    run
  end

  private

  def get_word
    dictionary = Dictionary.new
    dictionary.word
  end

  def run
    build_letters

    until game.won?
      render_tiles
      prompt_for_guess

      if @guesses_remaining == 0
        puts "You died."
        break
      end
    end

    puts "Play again? (Y/N)"
  end

  def build_letters
    unique_letters = @letters.uniq
    
    # this becomes a collection of letters and letter objects {"A" => LetterObject}
    @letter_pairs = {}

    unique_letters.each do |letter_value|
      letter_object = Letter.new(letter_value)
      @letter_pairs[letter_value] = letter_object
    end
  end

  def render_tiles
    @letters.each do |letter|
      letter_object = @letter_pairs[letter]
      puts letter_object.guessed? ? "_#{letter}_" : "___"
    end
  end

  def prompt_for_guess
    puts "Which letter would you like to guess?"
    letter = gets.chomp
    guess(letter)
  end

  def guess(letter_value)
    letter = @letter_pairs[letter_value]

    if letter
      puts "Correct!"
      letter.mark_guessed
    else
      puts "Incorrect guess!"
      @guesses_remaining -= 1
    end
  end

  def won?
    @letter_pairs.all? {|letter, letter_obj| letter.obj.guessed?}
  end
end