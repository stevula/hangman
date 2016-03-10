class Letter
  attr_reader :value

  def initialize(value)
    @value = value
    @guessed = false
  end

  def guessed?
    @guessed
  end

  def mark_guessed
    @guessed = true
  end
end