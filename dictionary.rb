class Dictionary
  def initialize
    @words = parse_dictionary
  end

  def word
    @words.sample
  end

  private

  def parse_dictionary(min_length: 0, max_length: 12)
    words = []

    dictionary = File.open('dictionary.txt')
    dictionary.each_line do |word| 
      word = word.chomp
      words << word if word.length.between?(min_length, max_length)
    end

    words
  end
end