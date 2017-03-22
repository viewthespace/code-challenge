def n(v)
  (v.split('.') + Array.new(3) { 0 }).take(3)
end

puts n(ARGV[0]).zip(n(ARGV[1])).map { |l, r| l <=> r }.reject { |i| i == 0 }.first || 0
