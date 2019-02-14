def is_valid matrix
  check = {}

  (0..8).each do |row|
    (0..8).each do |col|
      return false if check["r#{row}#{matrix[i][j]}"] || check["c#{col}#{matrix[i][j]}"] || check["q#{find_square(row, col)}#{matrix[i][j]}"]
      check["r#{row}#{matrix[i][j]}"] = 1
      check["c#{col}#{matrix[i][j]}"] = 1
      check["q#{find_square(row, col)}#{matrix[i][j]}"] = 1

  true
end

def find_square row, col
  else if(row < 3 && col < 3)
    return 1
  else if(row < 3 && col < 6)
    return 2
  else if(row < 3)
    return 3
  else if(row < 6 && col < 3)
    return 4
  else if(row < 6 && col < 6)
    return 5
  else if(row < 6)
    return 6
  else if(col < 3)
    return 7
  else if(col < 6)
    return 8
  return 9
end


def valid_entry entry
  entry == '' || (entry > 0 && entry < 10)
end
