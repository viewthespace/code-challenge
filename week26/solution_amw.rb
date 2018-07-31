#!/usr/bin/env ruby
N = 5

Position = Struct.new(:rank, :file) do
  def to_s
    "(#{rank}, #{file})"
  end
end

def within_board?(position)
  position.rank >= 0 && position.file >= 0 &&
    position.rank < N && position.file < N
end

def moves_from(position:)
  [
    [-2, -1], [-2, 1], [2, -1], [2, 1],
    [-1, -2], [-1, 2], [1, -2], [1, 2]
  ].each_with_object([]) do |(rank_diff, file_diff), moves|
    next_position = Position.new(
      position.rank + rank_diff,
      position.file + file_diff
    )
    moves << next_position if within_board?(next_position)
  end
end

def find_tour(position:, visited: {}, solution_path: [])
  solution_path << position

  return true if solution_path.length == N * N

  visited[position] = true
  found_tour = false

  moves_from(position: position).each do |next_position|
    next if visited[next_position]

    found_tour = find_tour(
      position: next_position,
      visited: visited,
      solution_path: solution_path
    )
    return solution_path if found_tour
  end

  solution_path.pop
  visited[position] = nil

  false
end

if tour = find_tour(position: Position.new(2, 2))
  puts tour
else
  puts 'No tour found from this starting position'
end

puts "Max length was: #{$max_length}"
