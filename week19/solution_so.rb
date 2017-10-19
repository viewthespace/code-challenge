# Runtime O(nk)
# Memory O(n)
def knight_probability(n, k, r, c)

  edges = -> (n, r, c) do
    [ [2, 1], [2,-1], [-2, 1], [-2, -1], [1, 2], [-1, 2], [1, -2], [-1, -2] ]
    .map { |m| [m[0] + r, m[1] + c]  }
    .reject { |m| m[0] < 0 || m[0] > n - 1 || m[1] < 0 || m[1] > n - 1  }
  end

  m = Array.new(k) { {} } 

  (0...k).each do |k|
    (0...n).each do |r|
      (0...n).each do |c|
        if k == 0
          m[k][r * n + c] = edges.call(n,r,c).count
        else
          m[k][r * n + c] = edges.call(n,r,c).reduce(0) { |sum, edge| sum + m[k-1][edge[0] * n + edge[1]]  }
        end
      end 
    end
  end

  m[k-1][r * n + c] / 8.0**k

end