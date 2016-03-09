class Game
  def initialize
    @word = pick_word
  end

  private

  def pick_word
    min_length = 5
    max_length = 12
    words = parse_dictionary(min_length: min_length, max_length: max_length)
  end

  def parse_dictionary(min_length: min, max_length: max)
    words = []

    dictionary = File.open('dictionary.txt')
    dictionary.each_line do |word| 
      word = word.chomp
      words << word if word.length.between?(min_length, max_length)
    end

    words
  end
end