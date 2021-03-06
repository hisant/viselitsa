class Game
  attr_reader :errors, :letters, :good_letters, :bad_letters

  attr_accessor :version, :status

  MAX_ERRORS = 7

  def initialize(word)
    @letters = get_letters(word)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = :in_progress # :won, :lost
  end

  def get_letters(word)
    if word == nil || word == ""
      abort "Слово не найдено"
    end

    word.split("")
  end

  def ask_next_letter
    puts "\n Введите следующую букву"
    letter = ""

    while letter == "" do
      letter = UnicodeUtils.downcase(STDIN.gets.encode("UTF-8").chomp)
    end

    next_step(letter)
  end

  def max_errors
    MAX_ERRORS
  end

  def errors_left
    MAX_ERRORS - @errors
  end

  def is_good?(letter)
    letters.include?(letter) ||
      (letter == "е" && letters.include?("ё")) ||
      (letter == "ё" && letters.include?("е")) ||
      (letter == "и" && letters.include?("й")) ||
      (letter == "й" && letters.include?("и"))
  end

  def add_letter_to(letters, letter)
    letters << letter

    case letter
      when "и" then letters << "й"
      when "й" then letters << "и"
      when "е" then letters << "ё"
      when "ё" then letters << "е"
    end
  end

  def solved?
    (@letters - @good_letters).empty?
  end

  def lost?
    @status == :lost || @errors >= MAX_ERRORS
  end

  def repeated?(letter)
    @good_letters.include?(letter) || @bad_letters.include?(letter)
  end

  def in_progress?
    @status == :in_progress
  end

  def won?
    @status == :won
  end

  def next_step(letter)
    return if status == :lost || status == :won
    return if repeated?(letter)

    if is_good?(letter)
      add_letter_to(@good_letters, letter)

      self.status = :won if solved?
    else
      add_letter_to(@bad_letters, letter)

      @errors += 1

     self.status = :lost if lost?
    end
  end
end