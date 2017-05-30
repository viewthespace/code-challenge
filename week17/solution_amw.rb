INPUT_SHORT = [
  '172.26.32.162/32',
  '172.26.32.0/24',
  '172.26.0.0/16'
].freeze

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
].freeze

def significant_octets(bits)
  (bits.to_f / 8).ceil
end

def bit_suffix(cidr)
  cidr.split('/')[1]
end

def pad_bits(significant_bits)
  7.downto(8 - significant_bits).reduce(0) { |a, e| a + 2**e }
end

def calculate_max_octets(cidr, significant_octets, num_bits)
  remaining_bits = num_bits.to_i % 8
  octets = octets(cidr)
  if remaining_bits.zero?
    octets.take(significant_octets)
  else
    octets.take(significant_octets - 1) << pad_bits(remaining_bits)
  end
end

def max_octets(cidr)
  num_bits = bit_suffix(cidr)
  num_octets = significant_octets(num_bits)
  octets = calculate_max_octets(cidr, num_octets, num_bits)
  (4 - num_octets).times { octets << 255 }
  octets
end

def octets(cidr)
  cidr.split('/')[0].split('.').map(&:to_i)
end

def to_i(octets)
  octets.reverse.map.with_index { |e, i| e * 1 << (8 * i) }.reduce(&:+)
end

def within?(range1, range2)
  range2.begin > range1.begin && range2.end < range1.end
end

def to_range(cidr)
  initial_octets = octets(cidr)
  max_octets = max_octets(cidr)
  to_i(initial_octets)..to_i(max_octets)
end

def remove_indexes(collection, indexes)
  collection.reject.with_index { |_, i| indexes.include? i }
end

def diagnose_covering_sets(cidr, covering_set)
  covered = false
  covering = false
  deletion_indexes = []
  new_range = to_range(cidr)
  covering_set.each_with_index do |covering_cidr, i|
    if within?(to_range(covering_cidr), new_range)
      covered = true
    elsif within?(new_range, to_range(covering_cidr))
      covering = true
      deletion_indexes << i
    end
  end
  [covered, covering, deletion_indexes]
end

def solve(input)
  covering_set = []
  input.each do |cidr|
    covered, covering, deletion_indexes = diagnose_covering_sets(cidr, covering_set)
    covering_set = remove_indexes(covering_set, deletion_indexes) if covering
    covering_set << cidr unless covered
  end
  puts 'Result'
  puts covering_set
  puts
end

solve(INPUT_SHORT)
solve(INPUT_FULL)
