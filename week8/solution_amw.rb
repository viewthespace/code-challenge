def neighbor_coords(row, column, matrix)
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

def downstream_min_coords(i, j, min_coords, matrix)
  neighbor_coords = neighbor_coords(i, j, matrix)
  min_neighbor_coords = min_neighbor_coords(neighbor_coords, matrix)
  neighbor_min_coords = neighbor_coords & min_coords
  if min_coords.include?([i, j])
    [i, j]
  elsif neighbor_min_coords.count > 0
    min_neighbor_coords
  else
    new_i, new_j = min_neighbor_coords
    downstream_min_coords(new_i, new_j, min_coords, matrix)
  end
end

matrix = [
  [1, 5, 2],
  [2, 4, 7],
  [3, 6, 9]
]

# matrix = [
#   [1, 0, 2, 5, 8],
#   [2, 3, 4, 7, 9],
#   [3, 5, 7, 8, 9],
#   [1, 2, 5, 4, 2],
#   [3, 3, 5, 2, 1]
# ]

# [0, 0] => A
# [1, 2] => B
#
# TODO:
# i, j to curr_point
def go_downstream(i, j, matrix, curr_basin, basins, seen_basins)
  puts
  puts "==== Frame ===="
  puts "(#{i},#{j}) => #{matrix[i][j]}"

  neighbor_coords = neighbor_coords(i, j, matrix)
  min_i, min_j = min_neighbor_coords(neighbor_coords, matrix)

  if seen_basins[[i, j]]
    puts 'hit cache'
    return seen_basins[[i, j]]
  end

  if [i, j] == [min_i, min_j]
    puts 'found min'
    basins[$curr_basin] ||= 1
    basin = $curr_basin
    puts "caching basin: #{basin}"
    seen_basins[[i, j]] = basin
    $curr_basin += 1
  else
    puts 'not min, recursing'
    basin = go_downstream(min_i, min_j, matrix, $curr_basin, basins, seen_basins)
    puts "caching basin: #{basin}"
    seen_basins[[i, j]] = basin
  end
end

min_coords = []
local_mins = []
basins = {}
$curr_basin = 0
seen_basins = {}
matrix.each_with_index do |row, i|
  row.each_with_index do |element, j|
    go_downstream(i, j, matrix, $curr_basin, basins, seen_basins)
  end
end

puts basins.to_s
puts seen_basins.to_s

# matrix.each_with_index do |row, i|
#   row.each_with_index do |element, j|
#     min_coords << [i, j] if element < neighbor_coords(i, j, matrix).map { |coord| element(coord, matrix) }.min
#   end
# end

# curr_basin = 0
# basins = {}

# min_coords.each do |coords|
#   basins[coords] = curr_basin
#   curr_basin += 1
# end

# matrix.each_with_index do |row, i|
#   row.each_with_index do |element, j|
#     downstream_min_coords = downstream_min_coords(i, j, min_coords, matrix)
#     basins[[i, j]] = basins[downstream_min_coords]
#   end
# end

# letters = ['A', 'B', 'C', 'D', 'E']

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
