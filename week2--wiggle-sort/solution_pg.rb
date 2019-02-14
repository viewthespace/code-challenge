# Time complexity: O(n*log(n))
# Space complexity - in-place ( O(1) )

# Single node of a linked list
class Node

  attr_accessor :value
  attr_accessor :next
  attr_accessor :previous

  def initialize val
    @value = val
  end

  def to_s
    value.to_s
  end

end

# Linked list implementation with some useful methods
class LinkedList

  attr_accessor :first
  attr_accessor :last

  def initialize arr=[]
    arr.each do |item|
      new_node = Node.new(item)
      add_to_list new_node
    end
  end

  def add_to_list node
    if self.last.present?
      self.last.next = node
      node.previous = self.last
      self.last = node
    else
      self.first = node
      self.last = node
    end
  end

  def add_to_beginning node
    if self.first.present?
      self.first.previous = node
      node.next = self.first
      self.first = node
    else
      self.first = node
      self.last = node
    end
  end

  def pop
    popped_node = self.last
    self.last = self.last.previous
    if self.last.present?
      self.last.next = nil
    else
      self.first = nil
    end
    popped_node.next = nil
    popped_node.previous = nil
    popped_node
  end

  def pop_from_beginning
    popped_node = self.first
    self.first = self.first.next
    if self.first.present?
      self.first.previous = nil
    else
      self.last = nil
    end
    popped_node.next = nil
    popped_node.previous = nil
    popped_node
  end

  def to_s
    array = []
    current_node = first
    while current_node != nil do
      array << current_node
      current_node = current_node.next
    end
    array.map(&:to_s).to_s
  end

end



# Actual solution
class WiggleSorter

  def initialize arr
    @list = LinkedList.new(arr.sort)
  end

  def wiggle
    sorted_list = LinkedList.new
    while @list.last.present?
      sorted_list.add_to_list @list.pop_from_beginning
      sorted_list.add_to_list @list.pop if @list.last.present?
    end
    sorted_list
  end

end
