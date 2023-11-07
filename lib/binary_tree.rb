# 1 - Write an #insert and #delete method which accepts a value to insert/delete. 
## You’ll have to deal with several cases for delete, such as when a node has children or not.
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
  
  def level_order
    queue = []
    queue.push(@root)

    while(!queue.empty?)
      current = queue.shift
      print "#{current.data} "
      queue.push(current.left) if (current.left)
      queue.push(current.right) if (current.right) 
    end
  end
  
  def inorder(node = @root)
    return if node.nil?

    inorder(node.left)
    print "#{node.data} "
    inorder(node.right)
  end

  def preorder(node = @root)
    return if node.nil?
    
    print "#{node.data} "
    preorder(node.left)
    preorder(node.right)
  end

  def postorder(node = @root)
    return if node.nil?

    postorder(node.left)
    postorder(node.right)
    print "#{node.data} "
  end

  def find(value, node = @root)
    return puts "The value of #{value} is present in #{node}." if node.nil? || node.data == value

    find(value, node.left) if value < node.data
    find(value, node.right) if value > node.data
  end

  def depth(value, node_depth = 0, node = @root)
    return puts "The node #{value} isn't present in this tree." if node.nil? 
    return puts "The depth of node #{node.data} is #{node_depth}." if node.data == value
    
    depth(value, node_depth += 1, node.left) if value < node.data
    depth(value, node_depth += 1, node.right) if value > node.data
  end

  def find_height(value, node = @root)
    return -1 if node.nil?

    left_height = find_height(value, node.left)
    right_height = find_height(value, node.right)
    ans = [left_height, right_height].max + 1

    @node_height = ans if node.data == value

    ans
  end

  def height(value)
    @node_height = nil
    find_height(value, @root)
    @node_height
    puts "The node with value of #{value} has a height of #{@node_height}."
  end

  def pretty_order
    puts 'Binary Search Tree Traversals:' ; puts ''
    puts '┌─ Level order '
    level_order ; puts ''
    puts '┌─ Inorder'
    inorder ; puts '' 
    puts '┌─ Preorder'
    preorder ; puts ''
    puts '┌─ Postorder'
    postorder ; puts '' ; puts ''
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
  # binary_tree = Tree.new(Array.new(15) { rand(1..100) })
  binary_tree.pretty_print
  binary_tree.find(7)
  binary_tree.depth(6345)
  binary_tree.height(7)
  binary_tree.pretty_order
end

main