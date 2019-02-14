# I think this is all supposed to be O(n log n) with some huge multiplier
# Or it would be if the CityBlock interval tree was balanced
# since it is not, this is probably O(n^2) instead
class CityBlock
  attr_accessor :max_height

  def initialize(building = nil)
    init(*building) if building
    self
  end

  def insert(building)
    return init(*building) if @interval.nil?
    more_left?(*building) ? add_to_left(building) : add_to_right(building)
    set_extremes *building
    self
  end

  def ultimate_height(edge)
    final_height = 0

    return final_height unless edge < @right_most_edge

    final_height = @height if @interval.cover?(edge)

    if @left_nodes && @left_nodes.max_height >= final_height
      left_height = @left_nodes.ultimate_height(edge)
      final_height = left_height if left_height > final_height
    end

    if @right_nodes && @right_nodes.max_height >= final_height
      right_height = @right_nodes.ultimate_height(edge)
      final_height = right_height if right_height > final_height
    end

    final_height
  end

  private

  def more_left?(left_edge, *_)
    left_edge < @interval.begin
  end

  def init(left_edge, right_edge, height)
    @interval = left_edge...right_edge
    @right_most_edge = right_edge
    @height = height
    @max_height = height
  end

  def set_extremes(_left_edge, right_edge, height)
    @right_most_edge = right_edge if right_edge > @right_most_edge
    @max_height = height if height > @max_height
  end

  def add_to_left(building)
    return @left_nodes.insert(building) if @left_nodes
    @left_nodes = CityBlock.new(building)
  end

  def add_to_right(building)
    return @right_nodes.insert(building) if @right_nodes
    @right_nodes = CityBlock.new(building)
  end
end

class YzSolutionWeek11
  def run(buildings)
    city = buildings.inject(CityBlock.new) do |city_block, building|
      city_block.insert building
      city_block
    end

    current_height = 0
    skyline = []

    buildings.flat_map { |b| b.take(2) }.uniq.sort.each do |edge|
      ultimate_height = city.ultimate_height edge
      next if ultimate_height == current_height

      skyline << [edge, ultimate_height]
      current_height = ultimate_height
    end

    puts skyline.inspect
    skyline
  end
end

YzSolutionWeek11.new.run([ [2,9,10], [3,7,15], [5,12,12], [15,20,10], [19,24,8] ])
# => [[2, 10], [3, 15], [7, 12], [12, 0], [15, 10], [20, 8], [24, 0]]
