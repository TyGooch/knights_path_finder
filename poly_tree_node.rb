class PolyTreeNode
attr_accessor :children
attr_reader :value, :parent

def initialize(val)
  @value = val
  @parent = nil
  @children = []
end

def parent=(parent)
  if parent.nil?
    @parent.children.delete(self)
  elsif parent != @parent && !@parent.nil?
    @parent.children.delete(self)
    parent.children << self unless parent.children.include? self
  else
    parent.children << self unless parent.children.include? self
  end
  @parent = parent
end

def add_child(child_node)
  @children << child_node
  child_node.parent = self
end

def remove_child(child)
  @children.delete(child)
  child.parent = nil
end

def dfs(target_value)
  return self if value == target_value
  output = nil
  @children.each do |child|
    output = child.dfs(target_value)
    break unless output == nil
  end
  output
end

def bfs(target_value)
  queue = [self]
  until queue.empty?
    node = queue.shift
    return node if node.value == target_value
    node.children.each do |child|
      queue << child
    end
  end

  nil
end

end
