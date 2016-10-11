def neighbor_coords(curr_point, matrix)
  row, column = curr_point
  top = [row - 1, column] if row != 0
  bottom = [row + 1, column] if row != matrix.size - 1
  left =  [row, column - 1] if column != 0
  right = [row, column + 1] if column != matrix.size - 1
  [top, bottom, left, right, [row, column]].compact
end

def element(indexes, matrix)
  matrix[indexes[0]][indexes[1]]
end

def min_neighbor_coords(neighbor_coords, matrix)
  neighbor_coords.map do |idx|
    { val: element(idx, matrix), coords: idx }
  end.each_with_index do |h, i|
    { val: h[:val], coords: h[:coords], idx: i }
  end.min_by do |h|
    h[:val]
  end[:coords]
end

# matrix = [
#   [1, 5, 2],
#   [2, 4, 7],
#   [3, 6, 9]
# ]

matrix = [
  [1, 0, 2, 5, 8],
  [2, 3, 4, 7, 9],
  [3, 5, 7, 8, 9],
  [1, 2, 5, 4, 2],
  [3, 3, 5, 2, 1]
]

# [0, 0] => A
# [1, 2] => B
#
# TODO:
# i, j to curr_point
def go_downstream(curr_point, matrix, curr_basin, basins, seen_basins)
  neighbor_coords = neighbor_coords(curr_point, matrix)
  min_point = min_neighbor_coords(neighbor_coords, matrix)

  if seen_basins[curr_point]
    return seen_basins[curr_point]
  end

  if curr_point == min_point
    basins[$curr_basin] ||= 1
    basin = $curr_basin
    seen_basins[curr_point] = basin
    $curr_basin += 1
    basin
  else
    basin = go_downstream(min_point, matrix, $curr_basin, basins, seen_basins)
    seen_basins[curr_point] = basin
    basins[basin] += 1
    basin
  end
end

min_coords = []
local_mins = []
basins = {}
$curr_basin = 0
seen_basins = {}
matrix.each_with_index do |row, i|
  row.each_with_index do |element, j|
    go_downstream([i, j], matrix, $curr_basin, basins, seen_basins)
  end
end

puts basins.to_s
puts seen_basins.to_s

letters = ['A', 'B', 'C', 'D', 'E']

# matrix.each_with_index do |row, i|
#   row.each_with_index do |element, j|
#     print(letters[basins[[i, j]]])
#   end
#   puts
# end

# puts

# basins.values.group_by { |i| i }.each do |k, v|
#   puts "Basin #{letters[k]} count: #{v.count}"
# end
