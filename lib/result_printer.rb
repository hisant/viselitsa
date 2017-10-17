class ResultPrinter
  def initialize(current_path, game)
    @status_image = []
    counter = 0

    while counter <= game.max_errors do
      file_name = current_path + "/image/#{counter}.txt"

      if File.exist?(file_name)
        f = File.new(file_name, 'r:UTF-8')
        @status_image << f.read
        f.close
      else
        @status_image << "\n[ Изображение не найдено ]\n"
      end

      counter += 1
    end
  end

  def cls
    (system "clear") || (system "cls")
  end

  def print_viselitsa(errors)
    puts @status_image[errors]
  end

  def print_status(game, word)
    cls
    puts game.version
    word_to_guess = get_word_for_print(game.letters, game.good_letters)
    puts "\nСлово: #{word_to_guess}"
    puts "Ошибки (#{game.errors}): #{game.bad_letters.join(", ")}"

    print_viselitsa(game.errors)
    @word = word

    if game.lost?
      puts "Вы проиграли :("
      puts "Было загадано слово: #{@word.to_s}"
    elsif game.won?
      puts "Поздравляем! Вы выиграли!\n\n"
    else
      puts "У вас осталось попыток: #{game.errors_left}"
    end
  end

  def get_word_for_print(letters, good_letters)
    result = ""

    for letter in letters do
      if good_letters.include? letter
        result += letter + " "
      else
        result += "__ "
      end
    end

    result
  end
end