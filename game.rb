class Game
  def initialize
    @dictionary = Dictionary.new
    run
  end

  private

  def get_word
    @dictionary.word
  end

  def run
    @word = get_word
    @letters = @word.split(//)
    @guesses_remaining = @word.length

    build_letters

    until won?
      render_tiles
      prompt_for_guess

      if @guesses_remaining == 0
        puts "You died."
        break
      end
    end

    # show final board
    render_tiles

    # retry or abort
    retry_or_abort
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
    puts "Guessing remaining: #{@guesses_remaining}"
    @letters.each do |letter|
      letter_object = @letter_pairs[letter]
      print letter_object.guessed? ? "_#{letter}_ " : "___ "
    end
    puts
  end

  def prompt_for_guess
    puts "Which letter would you like to guess?"
    letter = gets.chomp
    guess(letter)
  end

  def guess(letter_value)
    letter = @letter_pairs[letter_value.downcase]

    if letter
      puts "Correct!"
      puts
      letter.mark_guessed
    else
      puts "Incorrect guess!"
      puts
      @guesses_remaining -= 1
    end
  end

  def won?
    @letter_pairs.all? {|letter, letter_obj| letter_obj.guessed?}
  end

  def retry_or_abort
    puts "Play again? (Y/N)"
    response = gets.chomp

    response.upcase == "Y" ? run : abort("Thanks for playing!")
  end
end