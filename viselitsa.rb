if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

current_path = "./" + File.dirname(__FILE__)

require "active_support/all"
require current_path + "/game.rb"
require current_path + "/result_printer.rb"
require current_path + "/word_reader.rb"

reader = WordReader.new
word = reader.read_from_file(current_path + '/data/words.txt')
printer = ResultPrinter.new
game = Game.new(word)

while game.status == 0 do
  printer.print_status(game, word)
  game.ask_next_letter
end

printer.print_status(game, word)