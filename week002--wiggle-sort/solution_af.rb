# Given an array of integers, sort them such that
# nums[0] <= nums[1] >= nums[2] <= nums[3] >= nums[4]
#
# INPUT: [1,2,3,4,5]
# OUTPUT: [1,5,2,4,3] OR [1,4,2,5,3]

def wiggle_sort(nums_array)
  wiggle_sorted_array = []
  wiggle_sorted_array << nums_array.sort!.shift
  until nums_array.empty? do
    comp_array = nums_array.shift(2)
    wiggle_sorted_array << comp_array[1]
    wiggle_sorted_array << comp_array[0]
  end
  wiggle_sorted_array
end

