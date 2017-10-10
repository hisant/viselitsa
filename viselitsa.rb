if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

current_path = "./" + File.dirname(__FILE__)

require "unicode_utils/downcase"
require_relative "game"
require_relative "result_printer"
require_relative "word_reader"

reader = WordReader.new
word = reader.read_from_file("#{current_path}/data/words.txt")
printer = ResultPrinter.new
game = Game.new(word)

while game.status.zero? do
  printer.print_status(game, word)
  game.ask_next_letter
end

printer.print_status(game, word)