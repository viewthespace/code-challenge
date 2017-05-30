INPUT_SHORT = [
  '172.26.32.162/32',
  '172.26.32.0/24',
  '172.26.0.0/16',
]

INPUT_FULL = [
  '192.168.0.0/16',
  '172.24.96.17/32',
  '172.50.137.225/32',
  '202.139.219.192/32',
  '172.24.68.0/24',
  '192.183.125.71/32',
  '201.45.111.138/32',
  '192.168.59.211/32',
  '192.168.26.13/32',
  '172.24.0.0/17',
  '172.24.5.1/32',
  '172.24.68.37/32',
  '172.24.168.32/32'
]

def significant_sections(bits)
  (bits.to_f / 8).ceil
end

def bit_suffix(cidr)
  cidr.split("/")[1]
end

def max_address_sections(cidr)
  num_bits = bit_suffix(cidr)
  num_sections = significant_sections(num_bits)
  remaining_bits = num_bits.to_i % 8
  sections = address_sections(cidr)
  sections = if remaining_bits == 0
    sections.take(num_sections)
  else
    sections.take(num_sections - 1) << 7.downto(8 - remaining_bits).reduce(0) { |a, i| a + 2 ** i }
  end
  (4 - num_sections).times { sections << 255 }
  sections
end

def address_sections(cidr)
  cidr.split("/")[0].split(".").map(&:to_i)
end

def to_i(sections)
  sections.reverse.map.with_index { |e, i| e * 1 << (8 * i) }.reduce(&:+)
end

def within?(range1, range2)
  range2.begin > range1.begin && range2.end < range1.end
end

def to_range(cidr)
  sections = address_sections(cidr)
  max_sections = max_address_sections(cidr)
  to_i(sections)..to_i(max_sections)
end

def solve(input)
  covering_set = []
  covering_set << input[0]
  input.drop(1).each do |cidr|
    range = to_range(cidr)
    covered_by = false
    covering = false
    indexes = []
    covering_set.each_with_index do |a, i|
      if within?(to_range(a), range)
        covered_by = true
      elsif within?(range, to_range(a))
        covering = true
        indexes << i
      end
    end
    if covering
      covering_set = covering_set.reject.with_index { |a, i| indexes.include? i }
    end
    covering_set << cidr unless covered_by
  end
  puts "Result"
  puts covering_set
  puts
end

solve(INPUT_SHORT)
solve(INPUT_FULL)
