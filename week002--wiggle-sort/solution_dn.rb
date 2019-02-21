class Array

  def swap! (a, b)
    self[a], self[b] = self[b], self[a]
    self
  end

  # Traverses the array once O(n), but must sort it first.
  # Ruby uses quicksort O(nlogn) so solution is O(nlogn)
  def wiggle!
    self.sort!.rotate!(2).each_with_index do |i, a|
      self.swap!(i, i + 1) if i > 0 && i < self.length - 3 && i.odd?
    end
    self.swap!(self.length - 2, self.length - 3) if self.length.odd?
    self
  end
end
