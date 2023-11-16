# frozen_string_literal: true

class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

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

  ## Below are our methods for inserting / deleting nodes in our tree

  def insert(value, node = @root)
    return if node.nil? || node.data == value

    if value > node.data
      insert(value, node.right)
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    else
      insert(value, node.left)
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    end

    @array.push(value) unless @array.include?(value)
  end

  def insert_nodes
    rand(2..10).times do
      insert(rand(100..199))
    end
  end

  # This method, and its helper method, were built by RoPalma95 @ github
  def delete(value, node = @root)
    return node if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else

      return node.right if node.left.nil?
      return node.left if node.right.nil?

      leftmost_node = leftmost_leaf(node.right)
      node.data = leftmost_node.data
      node.right = delete(leftmost_node.data, node.right)
    end
    node
  end

  def leftmost_leaf(node)
    node = node.left until node.left.nil?

    node
  end

  ## Below are our traversal methods
  ## 'sleep' values are used for style reasons

  def level_order
    queue = []
    queue.push(@root)

    while(!queue.empty?)
      current = queue.shift
      print "#{current.data} "
      sleep 0.2
      queue.push(current.left) if current.left
      queue.push(current.right) if current.right
    end
  end

  # We build an array with the results to use in our 'balanced?' method
  def inorder(node = @root, inorder_array = [])
    return if node.nil?

    inorder(node.left, inorder_array)
    print "#{node.data} "
    sleep 0.2
    inorder_array.push(node.data)
    inorder(node.right, inorder_array)
    @inorder_array = inorder_array
  end

  def preorder(node = @root)
    return if node.nil?

    print "#{node.data} "
    sleep 0.2
    preorder(node.left)
    preorder(node.right)
  end

  def postorder(node = @root)
    return if node.nil?

    postorder(node.left)
    postorder(node.right)
    print "#{node.data} "
    sleep 0.2
  end

  ## Below are our methods that iterate over nodes and give us the requested data

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
    average_height = [left_height, right_height].max + 1

    @node_height = average_height if node.data == value

    average_height
  end

  def height(value)
    @node_height = nil
    find_height(value, @root)
    @node_height
    puts "The height of node #{value} is #{@node_height}."
  end

  # We perform an in-order traversal on our tree and store these values into a temp array.
  # If this array ends up with sorted ascending values, we have a balanced BST.
  # We use our 'inorder' method to push the BST values into a temp array,
  # and compare it to the original sorted array we use to build our BST.
  # This way, we can find out if our BST is balanced without having to write new code.
  def balanced?
    puts @inorder_array == @array ? 'This tree is balanced.' : 'This tree is not balanced.'
  end

  def rebalance
    @array = @inorder_array
    @root = build_tree(@inorder_array)
  end

  ## Below are our methods to make our inputs look good on the terminal

  def pretty_startup
    puts 'Binary Search Tree Builder Started.'
    sleep 2
    puts "Building a BST out of the following array: #{@array}"
    sleep 2
    puts ''
  end

  def pretty_order
    puts 'Building Binary Search Tree Traversals...'
    puts '┌─ Level order '
    level_order; puts ''
    puts '┌─ Inorder'
    inorder; puts ''
    puts '┌─ Preorder'
    preorder; puts ''
    puts '┌─ Postorder'
    postorder; puts ''
    puts 'Binary Search Tree Traversals Complete!'
    puts ''
  end

  def pretty_unbalancing
    puts 'Now, adding new random values to our array...'
    puts ''
    sleep 2
    puts "Building a BST out of the following array: #{@array}"
    sleep 2
    puts ''
  end

  def pretty_rebalancing
    puts "Let's rebalance this tree. Please wait..."
    puts ''
    sleep 2
    puts "Building a BST out of the following array: #{@array}"
    sleep 2
    puts ''
  end

  # This method was built by an unnamed Discord student from Odin Project. Thank you, unnamed student!
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    sleep 0.5
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

## Our driver script, which does the following, as requested by our assignment:
# 1 - Create a binary search tree from an array of random numbers
# 2 - Confirm that the tree is balanced by calling #balanced?
# 3 - Print out all elements in level, pre, post, and in order
# 4 - Unbalance the tree by adding several numbers > 100
# 5 - Confirm that the tree is unbalanced by calling #balanced?
# 6 - Balance the tree by calling #rebalance
# 7 - Confirm that the tree is balanced by calling #balanced?
# 8 - Print out all elements in level, pre, post, and in order.
def main
  binary_tree = Tree.new(Array.new(15) { rand(1..100) })
  binary_tree.pretty_startup
  binary_tree.pretty_print
  binary_tree.pretty_order
  binary_tree.balanced?
  binary_tree.insert_nodes
  binary_tree.pretty_unbalancing
  binary_tree.pretty_print
  binary_tree.pretty_order
  binary_tree.balanced?
  binary_tree.rebalance
  binary_tree.pretty_rebalancing
  binary_tree.pretty_print
  binary_tree.pretty_order
  binary_tree.balanced?
end

main
