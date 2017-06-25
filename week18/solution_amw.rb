# Runtime Complexity: O(n)
#
# Determines whether or not a binary tree is balanced
# by calculating the heights of each leaf node and ensuring
# that the max height is no more than 1 greater than the min
# height.
class Node
  attr_accessor :left, :right
  attr_reader :value

  def initialize(v)
    @left = nil
    @right = nil
    @value = v
  end
end

class BinaryTree
  def initialize(root_node)
    @root_node = root_node
  end

  def insert(node)
    _insert(node, @root_node)
  end

  def _insert(node, parent)
    belongs_left = node.value < parent.value
    belongs_right = !belongs_left
    if belongs_left && parent.left.nil?
      parent.left = node
    elsif belongs_right && parent.right.nil?
      parent.right = node
    else
      _insert(node, parent.left)  if belongs_left
      _insert(node, parent.right) if belongs_right
    end
  end

  def traverse(depth_map, &blk)
      _traverse(@root_node, depth_map, :root, 0, &blk)
  end

  def _traverse(parent, depth_map, direction, depth, &blk)
    yield parent if parent
    _traverse(parent.left, depth_map, :left, depth + 1, &blk)   if parent.left
    _traverse(parent.right, depth_map, :right, depth + 1, &blk) if parent.right
    depth_map[parent] = depth if parent.left.nil? && parent.right.nil?
  end
end

def balanced?(leaf_heights)
  (leaf_heights.max - leaf_heights.min) <= 1
end

def create_tree(values)
  BinaryTree.new(Node.new(values.delete_at(0))).tap do |tree|
    values.each do |i|
      tree.insert(Node.new(i))
    end
  end
end

def check_balanced(tree)
  depth_map = {}
  tree.traverse(depth_map) {}
  balanced?(depth_map.values)
end

not_balanced = [2, 3, 7, 8, 1, 9, 25, 29, 22, 33, 8, 7]
balanced = [8, 3, 1, 6, 4, 7, 10, 14, 13]

t = create_tree(not_balanced)
t2 = create_tree(balanced)

puts check_balanced(t)
puts check_balanced(t2)
