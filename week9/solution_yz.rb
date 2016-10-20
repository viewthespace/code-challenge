# [3, 5, 6, 3, 2, 2, 8, 6, 5, 5, 5]
#                      user     system      total        real
# holy_trinity_1   0.370000   0.010000   0.380000 (  0.372439)
# holy_trinity_2   0.300000   0.000000   0.300000 (  0.305964)
# holy_trinity_3   0.610000   0.000000   0.610000 (  0.609623)
# holy_trinity_4   0.160000   0.000000   0.160000 (  0.167345)

# [1, 4, 2, 3, 1, 5, 2, 4, 3]
#                      user     system      total        real
# holy_trinity_1   0.350000   0.010000   0.360000 (  0.349457)
# holy_trinity_2   0.240000   0.000000   0.240000 (  0.236129)
# holy_trinity_3   0.560000   0.000000   0.560000 (  0.570172)
# holy_trinity_4   0.140000   0.000000   0.140000 (  0.144508)

# naiive way, not terribly efficient
def holy_trinity_1(input_array)
  input_array.group_by { |v| v }.select { |k, v| v.length.odd? }.keys.first
end

# slightly more efficient than the naiive way, also takes less space
def holy_trinity_2(input_array)
  final = {}

  input_array.each do |v|
    final[v] = true unless final.delete(v).present?
  end

  final.keys.first
end

# a foray into how fancier data structures aren't always better - more overhead
def holy_trinity_3(input_array)
  final = Set.new

  input_array.each do |v|
    final << v unless final.delete?(v).present?
  end

  final.first
end

# optimal in both time and space, Neil deGrasse Tyson would be proud
def holy_trinity_4(input_array)
  input_array.reduce(0, &:^)
end

tests = [
  [3, 5, 6, 3, 2, 2, 8, 6, 5, 5, 5],
  [1, 4, 2, 3, 1, 5, 2, 4, 3]
]

holy_trinity_1(tests[0])
holy_trinity_2(tests[0])
holy_trinity_3(tests[0])
holy_trinity_4(tests[0])

holy_trinity_1(tests[1])
holy_trinity_2(tests[1])
holy_trinity_3(tests[1])
holy_trinity_4(tests[1])

tests.each do |test_case|
  puts "[#{test_case.join(', ')}]"
  Benchmark.bm(14) do |x|
    (1..4).each do |j|
      fn = "holy_trinity_#{j}"
      x.report(fn) do
        100000.times do
          send(fn, test_case)
        end
      end
    end
  end
end;
