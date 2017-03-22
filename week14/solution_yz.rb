def c(v, w)
  v = v.split('.')
  w = w.split('.')

  loop.with_index do |_, i|
    x = v[i].to_i
    y = w[i].to_i

    return -1 if x < y
    return 1 if x > y
    return 0 if x == y && (v[i].nil? || w[i].nil?)
  end
end
