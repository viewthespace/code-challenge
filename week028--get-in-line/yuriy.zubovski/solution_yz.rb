class GetInLine
  def initialize(points)
    @points = points.uniq
  end

  def max_line_points
    return points.length if points.length <= 2

    points
      .sort_by(&:to_s)
      .combination(2)
      .to_a
      .map(&method(:slope_intercept_first))
      .uniq
      .group_by(&:first)
      .values
      .map(&:length)
      .max
      .+(1)
  end

  private

  def slope_intercept_first(segment)
    x1, y1, x2, y2 = segment.flatten
    y_diff = y2 - y1
    x_diff = x2 - x1
    slope = x_diff == 0 ? nil : y_diff / x_diff.to_f
    y_intercept = x_diff == 0 ? x1 : y1 - slope * x1 # h4x0r
    [[slope, y_intercept].to_s, [x1, y1]]
  end

  attr_reader :points
end

class GetInLineTester
  TESTS = [
    { input: [], output: 0 },
    { input: [[1,1]], output: 1 },
    { input: [[1,1],[1,1]], output: 1 },
    { input: [[1,1],[1,1],[1,1]], output: 1 },
    { input: [[1,1],[1,2]], output: 2 },
    { input: [[1,1],[1,2],[1,3],[2,2]], output: 3 },
    { input: [[1,1],[2,2],[3,3]], output: 3 },
    { input: [[1,1],[3,2],[5,3],[4,1],[2,3],[1,4]], output: 4 }
  ]

  def initialize(klass = GetInLine)
    @klass = klass
  end

  def run(tests = TESTS)
    puts "Using #{klass.name}"

    tests.each do |test|
      begin
        puts "Testing #{test[:input]}"
        puts "Got #{klass.new(test[:input]).max_line_points}"
      rescue StandardError => e
        puts "Raised #{e.message}"
      ensure
        puts "Expected #{test[:output]}"
      end
    end
  end

  private

  attr_reader :klass
end

GetInLineTester.new.run
