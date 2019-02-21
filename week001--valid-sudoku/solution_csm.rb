
##
## I think this one is O(n) on a 9x9 matrix
## Space used = (3  9x9 arrays) + (Array of length 9) + (Hashset of length 9)
##


require 'set'

def valid (matrix)

  checked_set = Set.new
  path_array = []

  ## BLOCKS
  blocks = [
  [ [0,0], [0,1], [0,2], [1,0], [1,1], [1,2], [2,0], [2,1], [2,2]],
  [ [0,3], [0,4], [0,5], [1,3], [1,4], [1,5], [2,3], [2,4], [2,5]],
  [ [0,6], [0,7], [0,8], [1,6], [1,7], [1,8], [2,6], [2,7], [2,8]],
  [ [3,0], [3,1], [3,2], [4,0], [4,1], [4,2], [5,0], [5,1], [5,2]],
  [ [3,3], [3,4], [3,5], [4,3], [4,4], [4,5], [5,3], [5,4], [5,5]],
  [ [3,6], [3,7], [3,8], [4,6], [4,7], [4,8], [5,6], [5,7], [5,8]],
  [ [6,0], [6,1], [6,2], [7,0], [7,1], [7,2], [8,0], [8,1], [8,2]],
  [ [6,3], [6,4], [6,5], [7,3], [7,4], [7,5], [8,3], [8,4], [8,5]],
  [ [6,6], [6,7], [6,8], [7,6], [7,7], [7,8], [8,6], [8,7], [8,8]]
]
  blocks.each do |block|
    path_array.clear
    block.each do |pair|
      path_array << matrix[pair[0]][pair[1]]
    end
    return false unless check(path_array, checked_set)
  end

  ## ROWS
  rows = [
    [[0,0],[1,0],[2,0],[3,0],[4,0],[5,0],[6,0],[7,0],[8,0]],
    [[0,1],[1,1],[2,1],[3,1],[4,1],[5,1],[6,1],[7,1],[8,1]],
    [[0,2],[1,2],[2,2],[3,2],[4,2],[5,2],[6,2],[7,2],[8,2]],
    [[0,3],[1,3],[2,3],[3,3],[4,3],[5,3],[6,3],[7,3],[8,3]],
    [[0,4],[1,4],[2,4],[3,4],[4,4],[5,4],[6,4],[7,4],[8,4]],
    [[0,5],[1,5],[2,5],[3,5],[4,5],[5,5],[6,5],[7,5],[8,5]],
    [[0,6],[1,6],[2,6],[3,6],[4,6],[5,6],[6,6],[7,6],[8,6]],
    [[0,7],[1,7],[2,7],[3,7],[4,7],[5,7],[6,7],[7,7],[8,7]],
    [[0,8],[1,8],[2,8],[3,8],[4,8],[5,8],[6,8],[7,8],[8,8]]
  ]

  rows.each do |rows|
    path_array.clear
    rows.each do |pair|
      path_array << matrix[pair[0]][pair[1]]
      # puts "path at #{pair[0]} and #{pair[1]}"
      # puts path_array.inspect
    end
    # puts check(path_array, checked_set)
    return false unless check(path_array, checked_set)
  end

  ## COLUMNS
  columns = [
    [[0,0],[0,1],[0,2],[0,3],[0,4],[0,5],[0,6],[0,7],[0,8]],
    [[1,0],[1,1],[1,2],[1,3],[1,4],[1,5],[1,6],[1,7],[1,8]],
    [[2,0],[2,1],[2,2],[2,3],[2,4],[2,5],[2,6],[2,7],[2,8]],
    [[3,0],[3,1],[3,2],[3,3],[3,4],[3,5],[3,6],[3,7],[3,8]],
    [[4,0],[4,1],[4,2],[4,3],[4,4],[4,5],[4,6],[4,7],[4,8]],
    [[5,0],[5,1],[5,2],[5,3],[5,4],[5,5],[5,6],[5,7],[5,8]],
    [[6,0],[6,1],[6,2],[6,3],[6,4],[6,5],[6,6],[6,7],[6,8]],
    [[7,0],[7,1],[7,2],[7,3],[7,4],[7,5],[7,6],[7,7],[7,8]],
    [[8,0],[8,1],[8,2],[8,3],[8,4],[8,5],[8,6],[8,7],[8,8]]
  ]

  columns.each do |column|
    path_array.clear
    column.each do |pair|
      path_array << matrix[pair[0]][pair[1]]
    end
    return false unless check(path_array, checked_set)
  end

  ##If we got here, we're good
  return true;
end

def check(arr, set)
  set.clear
  arr.each{|x| set << x if x }
  arr.compact.length == set.length
end



def testit


  valid_matrices =
  [
    [
      [nil,nil,nil,nil,nil,nil,1,7,4],
      [nil,nil,nil,nil,nil,nil,2,8,5],
      [nil,nil,nil,nil,nil,nil,3,9,6],
      [nil, nil,nil,1,2,3,nil, nil ,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil ,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil ,nil],
      [1  ,2,4,5,6,7,8,3,9],
      [nil,nil, nil,nil, nil, nil,nil, nil ,nil],
      [nil, nil, nil,nil, nil, nil,nil, nil ,nil]
    ],

    [
      [nil, nil, nil, nil, nil, nil, nil, nil ,nil],
      [nil, nil, nil, nil, nil, nil, nil, nil ,nil],
      [nil, nil, nil, nil, nil, nil, nil, nil ,nil],
      [nil, nil, nil, nil, nil, nil, nil, nil ,nil],
      [nil, nil, nil, nil, nil, nil, nil, nil ,nil],
      [nil, nil, nil, nil, nil, nil, nil, nil ,nil],
      [nil, nil, nil, nil, nil, nil, nil, nil ,nil],
      [nil, nil, nil, nil, nil, nil, nil, nil ,nil],
      [nil, nil, nil, nil, nil, nil, nil, nil ,nil]
    ],

    [
      [1,9    , nil, nil, nil, nil, nil, nil ,    8    ],
      [2,8    , nil, nil,     9    , nil, nil, nil ,nil],
      [3,7    , nil, nil, nil, nil, nil, nil ,nil],
      [4    , nil, nil, nil, nil, nil, nil, nil ,nil],
      [5    , nil, nil, nil,     1    , nil, nil, nil ,nil],
      [6    , nil, nil, nil,     2    , nil, nil, nil ,nil],
      [7,3    , nil, nil, nil, nil, nil, nil ,nil],
      [8,2    , nil, nil, nil, nil, nil, nil ,nil],
      [9,1    , nil, nil, nil, nil, nil, nil ,    4    ]
    ]

  ]

  raise "SHIT FAILED" if valid_matrices.any?{|matrix| !valid(matrix) }


  invalid_matrices =
  [
    [
      [nil, nil, nil,    nil, nil, nil,        1    ,     7     ,    9    ],
      [nil, nil, nil,    nil, nil, nil,        2    ,     8     ,    5    ],
      [nil, nil, nil,    nil, nil, nil,        3    ,     4     ,    6    ],

      [nil, nil, nil,        1    ,     2    ,     3    ,    nil, nil ,nil],
      [nil, nil, nil,    nil, nil, nil,    nil, nil ,nil],
      [nil, nil, nil,    nil, nil, nil,    nil, nil ,nil],

      [    1    ,     2    ,     4    ,        5    ,     6    ,     7    ,        8    ,     3     ,    9    ],
      [nil, nil, nil,    nil, nil, nil,    nil, nil ,nil],
      [nil, nil, nil,    nil, nil, nil,    nil, nil ,nil]
    ],

    [
      [nil, nil, nil, nil, nil, nil, nil, nil ,nil],
      [nil, nil, nil, nil, nil, nil, nil, nil ,nil],
      [nil, nil, nil, nil, nil, nil, nil, nil ,nil],
      [    1    , nil, nil, nil, nil, nil, nil, nil ,nil],
      [nil, nil, nil, nil, nil, nil, nil, nil ,nil],
      [nil, nil,     1    , nil, nil, nil, nil, nil ,nil],
      [nil, nil, nil, nil, nil, nil, nil, nil ,nil],
      [nil, nil, nil, nil, nil, nil, nil, nil ,nil],
      [nil, nil, nil, nil, nil, nil, nil, nil ,nil]
    ],

    [
      [    1    ,     9    , nil, nil, nil, nil, nil, nil ,    8    ],
      [    2    ,     8    , nil, nil,     8    , nil, nil, nil ,nil],
      [    3    ,     7    , nil, nil, nil, nil, nil, nil ,nil],
      [    4    , nil, nil, nil, nil, nil, nil, nil ,nil],
      [    5    , nil, nil, nil,     1    , nil, nil, nil ,nil],
      [    6    , nil, nil, nil,     2    , nil, nil, nil ,nil],
      [    7    ,     3    , nil, nil, nil, nil, nil, nil ,nil],
      [    8    ,     2    , nil, nil, nil, nil, nil, nil ,nil],
      [    9    ,     1    , nil, nil, nil, nil, nil, nil ,    4    ]
    ]

  ]

  raise "SHIT FAILED" if invalid_matrices.any?{|matrix| valid(matrix)}




end

testit
