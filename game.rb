require_relative 'dictionary'
require_relative 'letter'

class Game
  def initialize
    @guesses_remaining = 7
    @word = get_word
    run
  end

  private

  def get_word
    dictionary = Dictionary.new
    dictionary.word
  end

  def run
    build_letters
    render_tiles
  end

  def build_letters
    letter_strings = @word.split(//).uniq
    
    @letter_pairs = letter_strings.map do |letter_value|
      letter_object = Letter.new(letter_value)
      {letter_value => letter_object}
    end
  end

  def render_tiles
    @letters.each do |letter|
      letter.guessed? ?  print "_#{letter}_" : print "___"
    end
  end

  def guess
  end
end