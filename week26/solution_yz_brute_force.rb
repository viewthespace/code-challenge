# Brute force for the slow.
# Test this with only like, 5x5 grid max, for your own sanity.
# Has 8! different operational complexities, depending on outcome of shuffle!
# Only takes ~half hour to run! *Actually, more like 2 hours and still no end in sight*
# Not quite O(n!), but trust me, we'll get there

require 'enumerator'

class Move
  attr_reader :x, :y, :width, :height

  DELTAS = [[2, -1], [2, 1], [-1, -2], [1, -2], [1, 2], [-2, 1], [-2, -1], [-1, 2]].shuffle.tap do |order|
    puts 'DELTAS = [' + order.map { |arr| "[#{arr[0]}, #{arr[1]}]" }.join(', ') + ']'
    puts "Good luck friend, you're going to need it!"
  end.map(&:freeze).freeze

  def initialize(x, y, width, height)
    @x = x
    @y = y
    @width = width
    @height = height
  end

  def next_moves
    DELTAS.map do |delta|
      Move.new(@x + delta[0], @y + delta[1], @width, @height)
    end.select(&:valid?)
  end

  def valid?
    @x >= 0 && @x < @width && @y >= 0 && @y < @height
  end

  def ==(other)
    self.class === other && other.x == @x && other.y == @y
  end

  alias eql? ==

  def hash
    (@y + 1) * @width + (@height - @x)
  end
end

class KnightsTourSolver
  attr_reader :moves, :width, :height, :loops

  def initialize(starting_x, starting_y, width, height)
    @moves = [Move.new(starting_x, starting_y, width, height)]
    @loops = 0
    @width = width
    @height = height
  end

  def knights_tour
    while @moves.size < @width * @height || @moves.last.nil?
      @loops += 1
      previous_last_move = nil

      if @moves.last.nil?
        *@moves, previous_last_move = @moves[0..-2]
      elsif @moves.last.next_moves.none?
        *@moves, @previous_last_move = @moves
      end

      next_moves = @moves.last.next_moves
      untested_moves = next_moves.drop((next_moves.index(previous_last_move) || -1) + 1)
      @moves << untested_moves.select { |next_move| @moves.index(next_move).nil? }.first
    end

    format_move_order
  end

  private

  def format_move_order
    @moves.each_with_index.each_with_object({}) do |(move, ix), fmt|
      fmt[move] = ix
    end.sort_by do |move, _ix|
      move.hash
    end.map do |_move, ix|
      ix
    end.each_slice(@width).to_a
  end
end

def knights_tour(x, y, width = 8, height = 8)
  tour = KnightsTourSolver.new(x, y, width, height)

  start_time = Time.now
  puts "Starting knight's tour from #{x}, #{y} (top, left) in #{width}x#{height} grid at #{start_time}"

  tour.knights_tour.each do |row|
    puts row.map { |order| '%02d' % order }.join(' ')
  end
rescue NoMethodError
  puts "... NO. That is IMPOSSIBLE. Get a bigger grid!"
ensure
  end_time = Time.now
  puts "Finished at #{end_time}, took #{end_time - start_time}, using #{tour.loops} loops"
end

knights_tour(0, 0)
