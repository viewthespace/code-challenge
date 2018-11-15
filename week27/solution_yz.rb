require 'enumerator'

class KnightDialer
  MOVES = [
    [4, 6].freeze,
    [6, 8].freeze,
    [7, 9].freeze,
    [4, 8].freeze,
    [0, 3, 9].freeze,
    [].freeze,
    [0, 1, 7].freeze,
    [2, 6].freeze,
    [1, 3].freeze,
    [2, 4].freeze
  ].freeze

  LIMITER = 10**9 + 7

  def self.distinct_numbers(length)
    raise 'OUT OF BOUNDS!' unless length >= 1 && length <= 5000

    combos = [1] * 10

    (length - 1).times do
      next_combos = []
      combos.each_with_index do |combo, cur_num|
        MOVES[cur_num].each do |next_num|
          next_combos[next_num] ||= 0
          next_combos[next_num] += combo
        end
      end
      combos = next_combos
    end

    combos.compact.sum % LIMITER
  end
end


[1,2,3,4,5,10,50,100,1000,5000].each do |length|
  puts "#{length} => #{KnightDialer.distinct_numbers(length)}"
end
