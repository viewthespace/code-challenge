# Time complexity O(n)
# Space complexity O(n)

# Walks matrix and finds flow direction
# If basin is missing, assigns basin of target
# If target basin is missing, assigns own basin
# Otherwise assigns new basin
# If own and target basins differ, saves basin pair for mapping
# Quashes saved basin pairs into final mapping
# Flattens result matrix and applies final mapping
# Groups, counts, sorts result
def drop_it_low(size, mat)
  ret = Array.new(size) { Array.new(size, nil) }
  basin_counter = 0
  basin_pairs = []

  for i in 0..(size-1)
    for j in 0..(size-1)
      here = mat[i][j]
      vertical = 0
      horizontal = 0
      diff = 0

      if i > 0
        north = mat[i-1][j]
        north_diff = north - here
        if north_diff < diff
          vertical = -1
          horizontal = 0
          diff = north_diff
        end
      end

      if j > 0
        west = mat[i][j-1]
        west_diff = west - here
        if west_diff < diff
          vertical = 0
          horizontal = -1
          diff = west_diff
        end
      end

      if i < size-1
        south = mat[i+1][j]
        south_diff = south - here
        if south_diff < diff
          vertical = 1
          horizontal = 0
          diff = south_diff
        end
      end

      if j < size-1
        east = mat[i][j+1]
        east_diff = east - here
        if east_diff < diff
          vertical = 0
          horizontal = 1
          diff = east_diff
        end
      end

      this_basin = ret[i][j] || ret[i+vertical][j+horizontal] || basin_counter
      that_basin = ret[i+vertical][j+horizontal] || ret[i][j] || basin_counter

      ret[i][j] = this_basin
      ret[i+vertical][j+horizontal] = that_basin

      basin_pairs << [this_basin, that_basin].sort if this_basin != that_basin

      basin_counter += 1 if this_basin == basin_counter || that_basin == basin_counter
    end
  end

  mappers = {}
  basin_pairs.uniq.sort_by { |p| p[0] * 10**size + p[1] }.each do |pair|
    mappers[pair[1]] = mappers[pair[0]] || pair[0]
  end

  ret.flatten.map { |b| mappers[b] || b }.group_by { |b| b }.map { |k, v| v.length }.sort.reverse
end

set1 = [3, [
  [1, 5, 2],
  [2, 4, 7],
  [3, 6, 9]
]];

ret1 = [7, 2];

set2 = [1, [[10]]];

ret2 = [1];

set3 = [5, [
  [1, 0, 2, 5, 8],
  [2, 3, 4, 7, 9],
  [3, 5, 7, 8, 9],
  [1, 2, 5, 4, 2],
  [3, 3, 5, 2, 1]
]];

ret3 = [11, 7, 7];

set4 = [4, [
  [0, 2, 1, 3],
  [2, 1, 0, 4],
  [3, 3, 3, 3],
  [5, 5, 2, 1]
]];

ret4 = [7, 5, 4];

drop_it_low(*set1)
ret1

drop_it_low(*set2)
ret2

drop_it_low(*set3)
ret3

drop_it_low(*set4)
ret4
