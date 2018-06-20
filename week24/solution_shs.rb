class RainCalc
  def self.calc array
    high_left = nil
    total_rain = 0
    potentials = Hash.new(0)

    array.each_with_index do |hill_size, idx|
      if idx == 0
        high_left = hill_size
        next
      end

      last_hill = array[idx - 1]
      last_hill_difference = hill_size - last_hill
      high_left_difference = hill_size - high_left

      if high_left_difference.negative? or high_left_difference.zero?  # less than high left
        high_left.downto(hill_size + 1) do |potential_height|
          potentials[potential_height] += 1
        end
        if last_hill_difference.positive? # we went up
          last_hill.upto(hill_size) do |height|
            total_rain += potentials[height]
            potentials.delete(height)
          end
        end
      else
        high_left = hill_size
      end
    end

    total_rain
  end
end

test_case_1 = [ 1, 3, 4, 2, 3, 5, 4, 5 ]
test_case_1_answer = 4
test_case_2 = [ 1, 2, 3, 2, 3, 1, 0, 1, 3 ]
test_case_2_answer = 8
test_case_3 = [ 5, 5, 5, 5, 5, 5, 5, 5, 5 ]
test_case_3_answer = 0
test_case_4 = [ 10, 1, 10, 9, 3, 30, 30, 30, 2 ]
test_case_4_answer = 17
test_case_4 = [ 3, 3, 1, 1, 2, 2, 1 ]
test_case_4_answer = 2

puts(RainCalc.calc(test_case_1), test_case_1_answer)
puts(RainCalc.calc(test_case_2), test_case_2_answer)
puts(RainCalc.calc(test_case_3), test_case_3_answer)
puts(RainCalc.calc(test_case_4), test_case_4_answer)
