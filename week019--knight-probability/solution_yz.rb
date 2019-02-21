def knight_probability(n, k, r, c)
  @max = n - 1
  @moves = [[-2,-1],[-1,-2],[-2,1],[-1,2],[1,-2],[2,-1],[2,1],[1,2]].map { |move| move.freeze }.freeze
  @numerator = 0
  @valid_moves_cache = {}
  @failures_cache = {}

  numerator = failure_count(k, r, c)

  puts "1 - #{numerator} / #{8**k}"
  1 - numerator.fdiv(8**k)
end

def failure_count(i, x, y)
  @failures_cache["#{i}_#{x}_#{y}"] ||= begin
    if i == 0
      0
    else
      opts = valid_moves(x, y)
      raw_failures = (8 - opts.size) * 8**(i - 1)
      expanded_failure = opts.sum { |new_x, new_y| failure_count(i - 1, new_x, new_y) }
      raw_failures + expanded_failure
    end
  end
end

def valid_moves(x, y)
  @valid_moves_cache[x * @max + y] ||= begin
    moves = @moves.map do |delta_x, delta_y|
      [x + delta_x, y + delta_y]
    end.reject do |new_x, new_y|
      !new_x.between?(0, @max) || !new_y.between?(0, @max)
    end
  end
end
