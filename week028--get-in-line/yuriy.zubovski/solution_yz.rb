class GetInLine
  def initialize(points)
    @points = points
  end

  def max_line_points
    raise 'Not Implemented'
  end

  private

  attr_reader :points
end

class GetInLineTester
  TESTS = [
    {
      input: [[1,1],[2,2],[3,3]],
      output: 3
    },
    {
      input: [[1,1],[3,2],[5,3],[4,1],[2,3],[1,4]],
      output: 4
    }
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
