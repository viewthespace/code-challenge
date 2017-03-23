def comp a, b
  a.split.zip(b.split).reduce(0) { |s, n| (n[0] || 0) <=> (n[1] || 0) }
end
