# @param {Integer[][]} nums
# @return {Integer[]}
def smallest_range(nums)
  range_size_map_of_ranges = {}
  list_count = nums.size

  value_map = value_map_of_list_indices(nums)

  value_map.each_with_index do |(value, list_indices), value_index|
    start_value = end_value = value

    value_map.drop(value_index + 1).each do |(next_value, next_list_indices)|
      break if list_indices.size == list_count
      end_value = next_value
      list_indices.merge!(next_list_indices)
    end

    break unless list_indices.size == list_count
    range_size_map_of_ranges[end_value - start_value] ||= [start_value, end_value]
  end

  range_size_map_of_ranges[range_size_map_of_ranges.keys.min]
end

def value_map_of_list_indices(arrays)
  value_map = {}

  arrays.each_with_index do |sorted_list, list_index|
    sorted_list.each do |value|
      value_map[value] ||= {}
      value_map[value][list_index] = true
    end
  end

  value_map.sort
end

puts smallest_range([[4,10,15,24,26], [0,9,12,20], [5,18,22,30]]).to_s
puts [20,24].to_s
