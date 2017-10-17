if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

current_path = "./#{File.dirname(__FILE__)}"

require "unicode_utils/downcase"
require "#{current_path}/lib/game.rb"
require "#{current_path}/lib/result_printer.rb"
require "#{current_path}/lib/word_reader.rb"

VERSION = "Игра \"Виселица\", версия 3."

reader = WordReader.new
word = reader.read_from_file("#{current_path}/data/words.txt")
game = Game.new(word)
game.version = VERSION
printer = ResultPrinter.new(current_path, game)

while game.in_progress? do
  printer.print_status(game, word)
  game.ask_next_letter
end

printer.print_status(game, word)