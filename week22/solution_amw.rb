# Space complexity: O(N) bits
# Time complexity:  O(1)

class BitLights
  attr_reader :bits

  def initialize(bits)
    @bits = bits
  end

  def is_on(index)
    bits & 1 << index > 0
  end

  def toggle(i, j)
    @bits = bits ^ toggle_mask(i, j)
    self
  end

  def to_s
    bits.to_s(2)
  end

  private

  def toggle_mask(i, j)
    2 * bit_for(j) - bit_for(i)
  end

  def bit_for(n)
    1 << n
  end
end

def test(initial_bits, toggle_i, toggle_j, expected_bits)
  lights = BitLights.new(initial_bits)
  toggled_bits = lights.toggle(toggle_i, toggle_j).bits
  result = toggled_bits == expected_bits

  raise error_msg(initial_bits, expected_bits) unless result
end

def error_msg(initial_bits, expected_bits)
  "Expected #{to_binary(initial_bits)} to equal #{to_binary(expected_bits)}"
end

def to_binary(n)
  n.to_s(2)
end

test(0b11110000, 0, 3, 0b11111111)
test(0b00001100, 2, 5, 0b000110000)
test(0b00000000, 0, 7, 0b11111111)
test(0b00010000, 4, 7, 0b11100000)

puts 'All test cases passed.'

