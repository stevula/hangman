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
    @guessed_letters = []
    @guesses_remaining = @word.length

    build_letters

    until won? || lost?
      render_tiles
      prompt_for_guess
    end

    # show final board
    render_tiles
    puts

    puts "You died. The word was #{@word}." if lost?
    puts "You won!" if won?

    # retry or abort
    retry_or_abort
  end

  # creates a hash of letters with associated letter objects
  def build_letters
    unique_letters = @letters.uniq
    
    @letter_pairs = {}

    unique_letters.each do |letter_value|
      letter_object = Letter.new(letter_value)
      @letter_pairs[letter_value] = letter_object
    end
  end

  def render_tiles
    puts "Letters guessed: #{@guessed_letters.join(", ") || 'none'}"
    puts "Guessing remaining: #{@guesses_remaining}"

    @letters.each do |letter|
      letter_object = @letter_pairs[letter]
      print letter_object.guessed? ? "_#{letter}_ " : "___ "
    end
    puts
  end

  def prompt_for_guess
    puts "Which letter would you like to guess?"
    letter = gets.chomp.upcase

    until validate_letter(letter)
      puts "Which letter would you like to guess?"
      letter = gets.chomp.upcase
    end

    guess(letter)
    @guessed_letters << letter
  end

  def validate_letter(letter)
    if letter.to_s.nil?
      puts "Letter cannot be blank!"
      return false
    end

    if @guessed_letters.include? letter
      puts "Guess a letter you haven't guessed yet!"
      return false 
    end

    if letter.length > 1
      puts "Must enter a single letter!"
      return false
    end

    if !letter.match(/[A-Z]/)
      puts "Must enter a letter character!"
      return false
    end

    true
  end

  def guess(letter_value)
    letter = @letter_pairs[letter_value]

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

  def lost?
    @guesses_remaining == 0
  end

  def retry_or_abort
    puts "Play again? (Y/N)"
    response = gets.chomp

    response.upcase == "Y" ? run : abort("Thanks for playing!")
  end
end