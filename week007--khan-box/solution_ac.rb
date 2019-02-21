# Khan Box

# Given an N x N matrix, write a function that returns the maximum
# number of rows that can be made into one uniform value given that
# the only way you can manipulate the matrix is by taking a column
# and flipping the bit of each element in that column. You may "flip"
# as many columns as you wish.

# Examples:

# Input:
# ```
# 4
# 0 1 1 0
# 1 1 0 0
# 1 0 0 1
# 1 0 1 1
# ```

# Output:
# ```
# 2
# ```

# Input:
# ```
# 3
# 1 1 0
# 0 1 1
# 0 1 0
# ```

# Output:
# ```
# 1
# ```

input1 = [
  [0, 1, 1, 0],
  [1, 1, 0, 0],
  [1, 0, 0, 1],
  [1, 0, 1, 1]
]

input2 = [
  [1, 1, 0],
  [0, 1, 1],
  [0, 1, 0]
]

def max_rows_for(input)
  all_flip_options = [*0...input.size]

  flipping_possibilities = input.map do |row|
    row.map.with_index do |item_in_row, column_position|
      next if item_in_row.zero?
      column_position
    end.compact
  end.map do |resulting_possibilities|
    [resulting_possibilities, (all_flip_options - resulting_possibilities)]
  end.flatten(1)

  flipping_possibilities.group_by { |x| x }.values.map(&:size).max
end

max_rows_for(input1)
# returns 2

max_rows_for(input2)
# returns 1
