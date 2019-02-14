# Runtime: N LOG(K)
# Memory: K
def smallest_range(nums)
  queue = []
  owner = Hash.new { [] }
  smallest_range = 0..Float::INFINITY
  nums.each_with_index do |list, i|
    queue << val = list.shift
    owner[val.to_s] = owner[val.to_s] << i
  end
  queue.sort!

  while(true) do
    a = queue.shift
    b = queue.last || a
    smallest_range = (a..b) if (a..b).size < smallest_range.size
    next_index = owner[a.to_s].shift
    next_list = nums[next_index]
    break if next_list.size == 0
    new_val = next_list.shift
    owner[new_val.to_s] = owner[new_val.to_s] << next_index
    i = b_search queue, new_val
    queue.insert(i, new_val)

  end
  [smallest_range.first, smallest_range.last] 
end

def b_search nums, val
  low = 0
  high = nums.size - 1
  while(low <= high) do
    mid = (low + high) >> 1
    if val > nums[mid]
      low = mid + 1
    elsif val < nums[mid]
      high = mid - 1
    else
      return mid
    end 
  end
  return low
end