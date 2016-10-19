def remove_dupes(arr)
  hash = {}
  arr.each do |val|
    if hash.key?(val)
      hash.delete(val) 
    else
      hash[val] = true
    end
  end
  p hash.keys
end

def remove_dupes2(arr)
  arr.group_by{ |v| v }.each{ |k, v| p k if v.size.odd? }
end

arr = [3, 5, 6, 3, 2, 2, 8, 6, 5, 5, 5]
arr2 = [1, 4, 2, 3, 1, 5, 2, 4, 3]

remove_dupes(arr)
remove_dupes(arr2)
remove_dupes2(arr)
remove_dupes2(arr2)
