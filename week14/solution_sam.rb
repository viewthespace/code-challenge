def comp a, b
  a.split.zip(b.split).reduce(0) { |s, n| s == 0 ? (n[0] || 0) <=> (n[1] || 0) : s }
end
