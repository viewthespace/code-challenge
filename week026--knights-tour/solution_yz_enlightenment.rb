# O(n!)

VALID_DISTANCES = [1,2].freeze

def knights_tour(x, y, width = 8, height = 8)
  start_time = Time.now
  loops = 0
  puts "Starting knight's tour from #{x}, #{y} (top, left) in #{width}x#{height} grid at #{start_time}"

  start_index = (width * y) + x
  board = []
  loop do
    loops += 1
    raw = (1..(width * height - 1)).to_a.shuffle
    move_order = [raw.first(start_index), 0, raw.drop(start_index)].flatten
    board = move_order.each_slice(width).to_a
    break if valid?(board)
  end

  board.each do |row|
    puts row.map { |order| '%02d' % order }.join(' ')
  end
ensure
  end_time = Time.now
  puts "Finished at #{end_time}, took #{end_time - start_time}, using #{loops} loops"
end

def valid?(board)
  get_moves(board).each_cons(2) do |pair|
    from, to = pair
    x_distance = (from[0] - to[0]).abs
    y_distance = (from[1] - to[1]).abs
    return false unless [x_distance, y_distance].sort == VALID_DISTANCES
  end
  true
end

def get_moves(finished_board)
  finished_board.each_with_index.each_with_object({}) do |(row, y_index), moves|
    row.each_with_index do |order, x_index|
      moves[order] = [x_index, y_index]
    end
  end.sort_by do |order, _move|
    order
  end.map do |_order, move|
    move
  end
end

knights_tour(0, 0, 8, 8)
