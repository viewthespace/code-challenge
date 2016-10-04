# khan_box_common_rows()
# Runtime: O( N^2 ), N being the height and width of the box
# Memory: O( N*LOG(N) ), where Log_2(N) is the memory footprint of a row bitmask

def khan_box_common_rows(input)
  input.map do |row|
    (row[0] == 1 ? row : row.map { |val| val^1 }).join.to_i(2)
  end.group_by { |val| val }.values.map(&:length).max
end

khan_box_common_rows([[0,1,1,0],[1,1,0,0],[1,0,0,1],[1,0,1,1]])

khan_box_common_rows([[1,1,0],[0,1,1],[0,1,0]])
