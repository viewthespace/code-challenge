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

def find_key_points(x_to_ys)
  key_points = []
  xs = x_to_ys.keys.sort
  key_points << x_to_ys[xs[0]]
  xs.each_with_index do |x, i|
    next if i == xs.count - 1

    ys_for_x = x_to_ys[x]
    xn = xs[i + 1]
    ys_for_xn = x_to_ys[xn]

    max_ys_x = ys_for_x.max
    max_ys_xn = ys_for_xn.max

    if max_ys_x != max_ys_xn
      key_points << resolve_key_point(x, max_ys_x, xn, max_ys_xn)
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

x_to_ys = collapse_heights(all_points)
x_to_ys.each { |k, v| puts "#{k} => #{v.to_s}" }

key_points = find_key_points(x_to_ys)
key_points.each { |kp| puts kp.to_s }
