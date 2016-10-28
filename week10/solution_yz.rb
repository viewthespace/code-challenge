# $ week9/profile ruby week10/solution_yz.rb
# Average run time: 0.51182
# File size: 1294
class Week10SolutionYz
  MAP_TO_PUNCTUATION = 'e'
  FROM_QWERTY = 'bcdfghijklnoprstuvxyqwz'.freeze
  TO_DVORAK   = 'xjeuidchtnbrlpoygkqf~~~'.freeze

  def initialize(input_file, output_file)
    @input_file = input_file
    @output_file = output_file
    @dvorak_to_qwerty = {}
  end

  def run
    prepare_dictionaries
    find_translations
  end

  private

  def prepare_dictionaries
    input = File.open(@input_file)
    input.each do |word|
      qwerty = word.downcase.chomp
      next if qwerty.include?(?e)
      dvorak = qwerty.tr(FROM_QWERTY, TO_DVORAK)
      @dvorak_to_qwerty[dvorak] = qwerty
    end
    input.close
  end

  def find_translations
    input = File.open(@input_file)
    input.each do |word|
      dvorak = word.downcase.chomp
      next if dvorak == @dvorak
      @dvorak = dvorak
      qwerty = @dvorak_to_qwerty[dvorak]
      output << "d:#{dvorak}|q:#{qwerty}\n" unless qwerty.nil?
    end
    output.close
    input.close
  end

  def output
    @output ||= File.open(@output_file, File::WRONLY | File::APPEND | File::CREAT | File::TRUNC)
  end
end

Week10SolutionYz.new('/usr/share/dict/words', 'week10/result_yz.txt').run
