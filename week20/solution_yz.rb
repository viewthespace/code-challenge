# @param {Integer[][]} nums
# @return {Integer[]}
def smallest_range(nums)
  value_map = value_map_of_list_indices(nums)
  range_size_map_of_ranges = {}
  list_count = nums.size

  # for each value, find the first end index that covers every list
  value_map.each_with_index do |(value, list_indices), value_index|
    start_value = end_value = value

    # skip all of the values that precede our starting point
    value_map.drop(value_index + 1).each do |(next_value, next_list_indices)|
      # if the size of the list_indices hash matches the list count,
      # then every list is already represented as a key, so we can stop
      break if list_indices.size == list_count

      # if we didn't stop, then the next value becomes the tentative end of the range
      end_value = next_value

      # all of the lists that contain this new end value are now covered by the range
      list_indices.merge!(next_list_indices)
    end

    # if we got here and the list_indices size is smaller than list_count,
    # then we are so deep in the values that we have passed the end of one or more lists
    # so we no further valid ranges can be created
    break unless list_indices.size == list_count

    # store the valid range with its size as the key, unless an earlier range of the same size exists
    range_size_map_of_ranges[end_value - start_value] ||= [start_value, end_value]
  end

  # get the range that has the smallest width
  range_size_map_of_ranges[range_size_map_of_ranges.keys.min]
end

# builds a hash where each key is a index that appears in one or more lists
# and the value is a hash whose keys are the indices of the lists the outer key came from
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
