#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'set'

module AutoFreeze
  def initialize(*args)
    super
    freeze
  end
end

Point = Struct.new(:x, :y) { include AutoFreeze }
Equation = Struct.new(:slope, :y_intercept, :x_intercept) { include AutoFreeze }

def parse_input(input)
  JSON.parse(input).map do |coord|
    Point.new(*coord)
  end
end

def linear_eq(point_a, point_b)
  a, b = point_a.x < point_b.x ? [point_a, point_b] : [point_b, point_a]
  slope = (a.y - b.y) / (a.x - b.x).to_f
  y_intercept = a.y - (slope * a.x)
  if slope.infinite?
    Equation.new(slope, 0, a.x)
  else
    Equation.new(slope, y_intercept)
  end
end

def find_lines(points)
  lines = Hash.new(Set.new.freeze)
  points.combination(2).each do |a, b|
    eq = linear_eq(a, b)
    unless eq.slope.nan?
      lines[eq] += [a, b]
    end
  end
  lines
end

points = parse_input($stdin.read)
puts case points.length
when 0 then 0
when 1 then 1
else
  find_lines(points).values.map(&:size).max
end
