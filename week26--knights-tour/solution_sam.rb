require 'rgl/adjacency'
require 'rgl/dot'
require 'graphviz'

SIZE = 5

require 'delegate'
require 'pry'
require 'pry-byebug'

Square = Struct.new(:index, :row, :column)

def build_graph_array
  board = Array.new(SIZE) do |row|
    Array.new(SIZE) do |column|
      Square.new((row * SIZE + column), row, column)
    end
  end

  build_valid_moves(board)
end

def set_move(graph_array, board, square, row_by, column_by)
  row = square.row + row_by
  column = square.column + column_by

  target_square = get_move(board, row, column)
  if target_square
    graph_array.push(square.index, target_square.index)
  end
end

def get_move(board, row, column)
  if row >= 0 && row < (SIZE) && column >= 0 && column < (SIZE)
    return board[row][column]
  end
end

def build_valid_moves board
  graph_array = []
  board.each do |row|
    row.each do |square|
      set_move(graph_array, board, square, -2, 1)
      set_move(graph_array, board, square, -2, -1)
      set_move(graph_array, board, square, -1, 2)
      set_move(graph_array, board, square, -1, -2)
      set_move(graph_array, board, square, 2, 1)
      set_move(graph_array, board, square, 2, -1)
      set_move(graph_array, board, square, 1, 2)
      set_move(graph_array, board, square, 1, -2)
    end
  end
  graph_array
end

graph_array = build_graph_array

DG = RGL::DirectedAdjacencyGraph[*graph_array]

first_vert = DG.vertices.first

def walk_until_done(vert, log = [])
  unvisted_verts = DG.adjacent_vertices(vert) - log

  new_log = log + [vert]

  if new_log.length == SIZE * SIZE
    return new_log
  else
    unvisted_verts.each do |v|
      val = walk_until_done(v, new_log)
      return val if !val.nil?
    end
    nil
  end
end

log = walk_until_done(first_vert)

puts(log)
