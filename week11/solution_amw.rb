#!/usr/bin/env ruby

def expand_coords(coords)
  x1, x2, h = coords
  (x1..x2).map { |x| [x, h] }
end

def collapse_heights(coords)
  x_to_ys = {}
  coords.each do |x, y|
    x_to_ys[x] ||= []
    x_to_ys[x] << y
  end
  x_to_ys
end

def resolve_key_point(x, max_y, xn, max_yn)
  if max_y > max_yn
    [xn, max_yn]
  else
    [x, max_yn]
  end
end

def find_key_points(overlapping_heights)
  key_points = []
  xs = overlapping_heights.keys.sort
  key_points << [xs[0], overlapping_heights[xs[0]].max]
  xs.each_with_index do |x, i|
    next if i == xs.count - 1

    heights_for_x = overlapping_heights[x]
    xn = xs[i + 1]
    heights_for_xn = overlapping_heights[xn]

    max_height_x = heights_for_x.max
    max_height_xn = heights_for_xn.max

    if max_height_x != max_height_xn
      key_points << resolve_key_point(x, max_height_x, xn, max_height_xn)
    end
  end
  key_points
end

buildings = [
  [2, 9, 10],
  [3, 7, 15],
  [5, 12, 12],
  [15, 20, 10],
  [19, 24, 8]
]

all_points = buildings.reduce([]) { |a, b| a + expand_coords(b) }
#all_points.each { |c| puts c.to_s }

overlapping_heights = collapse_heights(all_points)
overlapping_heights.each { |k, v| puts "#{k} => #{v.to_s}" }

key_points = find_key_points(overlapping_heights)
key_points.each { |kp| puts kp.to_s }
