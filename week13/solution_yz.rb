def unencodify(arr)
  sum = arr.inject(:+) / (arr.length - 1)
  arr.map { |val| sum - val }
end

puts unencodify([14, 13, 12, 11, 10]).inspect
puts unencodify([322, 177, 240, 295, 322, 289]).inspect
