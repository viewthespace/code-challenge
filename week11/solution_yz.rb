# I think this is all supposed to be O(n log n) with some huge multiplier
# Or it would be if the portfolio was balanced, but it's been decades since anyone
# has paid taxes on it, so it is probably O(n^2) instead
class RealEstatePortfolio
  attr_accessor :win_so_much

  def initialize(hotel_or_casino = nil)
    build_it(*hotel_or_casino) if hotel_or_casino
    self
  end

  def erect(best_building)
    return build_it(*best_building) if @bigness.nil?
    hotel_or_casino?(*best_building) ? erect_hotel(best_building) : erect_casino(best_building)
    add_to_portfolio *best_building
  end

  def winning(here_and_now)
    so_much_winning = 0

    return so_much_winning unless here_and_now < @bestness

    so_much_winning = @win if @bigness.cover?(here_and_now)

    if @hotels
      win_at_hotels = @hotels.winning(here_and_now) unless @hotels.win_so_much < so_much_winning
      so_much_winning = win_at_hotels if win_at_hotels && win_at_hotels > so_much_winning
    end

    if @casinos
      win_at_casinos = @casinos.winning(here_and_now) unless @casinos.win_so_much < so_much_winning
      so_much_winning = win_at_casinos if win_at_casinos && win_at_casinos > so_much_winning
    end

    so_much_winning
  end

  private

  def hotel_or_casino?(leftness, *_)
    leftness < @bigness.begin
  end

  def build_it(leftness, rightness, tallness)
    @bigness = leftness...rightness
    @bestness = rightness
    @win = tallness
    @win_so_much = @win
  end

  def add_to_portfolio(leftness, rightness, tallness)
    @bestness = rightness if rightness > @bestness
    @win_so_much = tallness if tallness > @win_so_much
    self
  end

  def erect_hotel(hotel)
    return @hotels.erect(hotel) if @hotels
    @hotels = RealEstatePortfolio.new(hotel)
  end

  def erect_casino(casino)
    return @casinos.erect(casino) if @casinos
    @casinos = RealEstatePortfolio.new(casino)
  end
end

class YzSolutionWeek11
  def run(hotels_and_casinos)
    portfolio = hotels_and_casinos.inject(RealEstatePortfolio.new) do |the_best_building, new_building|
      the_best_building.erect new_building
      the_best_building
    end

    tired_of_winning = 0
    so_much_winning = []

    hotels_and_casinos.flat_map { |b| b.take(2) }.uniq.sort.each do |here_and_now|
      winning = portfolio.winning here_and_now
      so_much_winning  << [here_and_now, winning] unless winning == tired_of_winning
      tired_of_winning = winning
    end

    puts so_much_winning.inspect
    so_much_winning
  end
end

YzSolutionWeek11.new.run([ [2,9,10], [3,7,15], [5,12,12], [15,20,10], [19,24,8] ])
# => [[2, 10], [3, 15], [7, 12], [12, 0], [15, 10], [20, 8], [24, 0]]
