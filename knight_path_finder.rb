require "./poly_tree_node.rb"

class KnightPathFinder
  attr_reader :start

  # Deltas for moves
  MOVES = [[-1,  2], #up
           [ 1,  2],
           [ 1, -2], #down
           [-1, -2],
           [ 2,  1], #right
           [ 2, -1],
           [-2,  1], #left
           [-2, -1],]

  def initialize(target, start = [0,0])
    @target = target
    @start = PolyTreeNode.new(start)
    @possible_spaces = []
  end

  def run
    build_move_tree(@start)
    p find_path.reverse
  end


  #building move tree
  def build_move_tree(node)
    possible_moves(node).each do |move|
      node.add_child(PolyTreeNode.new(move))
    end
    node.children.each {|child| build_move_tree(child)}
  end

  def is_valid_move?(move)
    x, y = move
    @possible_spaces.delete(@target)
    if (x < 0 || x > 7) || (y < 0 || y > 7)
      return false
    elsif @possible_spaces.include?(move)
      return false
    end

    true
  end

  def possible_moves(node)
    current_pos = node.value
    current_x, current_y = current_pos
    possible_arr = []
    MOVES.each do |move|
      next_x, next_y = move
      next_move = [current_x + next_x, current_y + next_y]
      possible_arr << next_move if is_valid_move?(next_move)
    end
    @possible_spaces += possible_arr
    possible_arr
  end

  #target_value
  def find_path
    target_path(@start.bfs(@target))
  end

  def target_path(node, path = [])
    if node.parent == nil
      path << node.value
      return path
    end
    path << node.value
    target_path(node.parent, path)
  end

end
