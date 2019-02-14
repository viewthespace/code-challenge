puts ARGV.map(&:to_i).reduce{|e,a|a^e}
