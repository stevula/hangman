require_relative 'dictionary'

class Game
  def initialize
    dictionary = Dictionary.new
    @word = dictionary.word
    @guesses_remaining = 5
  end

  private
end