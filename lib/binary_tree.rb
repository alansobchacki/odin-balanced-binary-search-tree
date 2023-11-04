# 1 - Write an #insert and #delete method which accepts a value to insert/delete. 
## You’ll have to deal with several cases for delete, such as when a node has children or not.
# 2 - Write a #level_order method which accepts a block. 
## This method should traverse the tree in breadth-first level order and yield each node to the provided block.
# 3 - Write #inorder, #preorder, and #postorder methods that accepts a block
## The methods should return an array of values if no block is given.
# 4 - Write a #height method that accepts a node and returns its height.
# 5 - Write a #depth method that accepts a node and returns its depth.
# 6 - Write a #balanced? method that checks if the tree is balanced.
# 7 - Write a #rebalance method which rebalances an unbalanced tree. 
## You’ll want to use a traversal method to provide a new array to the #build_tree method.

class Tree
  attr_reader :root

  def initialize(array)
    @array = array.uniq.sort
    @root = build_tree(@array)
  end

  def build_tree(array)
    return nil if array.empty?

    mid = array.length / 2
    root_node = Node.new(array[mid])
    root_node.left = build_tree(array[0...mid])
    root_node.right = build_tree(array[mid + 1..-1])
    root_node
  end
  
  def find(value)
    queue = []
    queue.push(@root)

    while(!queue.empty?)
      current = queue.shift

      if current.data == value then
        puts "The value of #{value} is present in the node #{current}."
        return
      end

      queue.push(current.left) if (current.left)
      queue.push(current.right) if (current.right) 
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

####

def main
  binary_tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
  binary_tree.pretty_print
  binary_tree.find(324)
end

main