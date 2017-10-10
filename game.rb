class Game
  def initialize(word)
    @letters = get_letters(word)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = 0
  end

  def get_letters(word)
    if (word == nil || word == "")
      abort "Вы не ввели слово для игры"
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

  def next_step(letter)
    if @status == -1 || @status == 1
      return # ничего не возвращает, но прерывает метод
    end

    if @good_letters.include?(letter) || @bad_letters.include?(letter)
      return
    end

    if @letters.include?(letter)
      @good_letters << letter

      if @good_letters.size == @letters.uniq.size
        @status = 1
      end

    else
      @bad_letters << letter
      @errors += 1

      if @errors >= 7
        @status = -1
      end
    end
  end

  def letters
    @letters
  end

  def good_letters
    @good_letters
  end

  def bad_letters
    @bad_letters
  end

  def status
    @status
  end

  def errors
    @errors
  end
end