class WordReader
  def read_from_file(file_name)
    if File.exist?(file_name)
      f = File.new(file_name, 'r:UTF-8')
      lines = f.readlines
      f.close
      UnicodeUtils.downcase(lines.sample.chomp)
    else
      puts "Файл не найден."
    end
  end
end