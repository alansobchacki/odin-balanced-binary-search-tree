# 1 - Write an #insert and #delete method which accepts a value to insert/delete. 
## You’ll have to deal with several cases for delete, such as when a node has children or not.

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