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

ALL_ONES = 0xffffffff

def bit_suffix(cidr)
  cidr.split('/')[1].to_i
end

def address(cidr)
  cidr.split('/')[0]
end

def max_address(cidr)
  initial_address = to_i(address(cidr))
  initial_address | (ALL_ONES >> bit_suffix(cidr))
end

def octets(cidr)
  cidr.split('/')[0].split('.').map(&:to_i)
end

def to_i(ip)
  octets(ip).reverse.map.with_index { |e, i| e * 1 << (8 * i) }.reduce(&:+)
end

def within?(range1, range2)
  range2.begin > range1.begin && range2.end < range1.end
end

def to_range(cidr)
  to_i(address(cidr))..max_address(cidr)
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
