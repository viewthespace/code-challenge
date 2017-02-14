def u(r);s=r.inject(:+)/(r.length-1);r.map{|v|s-v};end

puts u([14, 13, 12, 11, 10]).inspect
puts u([322, 177, 240, 295, 322, 289]).inspect
