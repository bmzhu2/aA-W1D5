require_relative '00_tree_node.rb'

class KnightPathFinder
    attr_reader :root_node, :considered_positions

    def self.valid_moves(pos)
        moves = [[1, 2],[1,-2],[-1, -2],[-1,2],[2,1],[2,-1],[-2,-1],[-2,1]]
        potential_positions = moves.map {|move| [pos[0] + move[0], pos[1] + move[1]]}
        valid = potential_positions.select do |position|
            (0...8).include?(position[0]) && (0...8).include?(position[1])
        end
    end

    def initialize(start_position)
        @root_node = PolyTreeNode.new(start_position)
        build_move_tree
    end

    def build_move_tree
        @considered_positions = [root_node.value].to_set
        
        new_move_positions(root_node.value).each do |child_position|
            root_node.add_child(PolyTreeNode.new(child_position))
        end

        queue = root_node.children
        until queue.empty?
            current_position = queue.shift
          
            new_move_positions(current_position.value).each do |child_position|
                current_position.add_child(PolyTreeNode.new(child_position))
            end

            queue += current_position.children 
        end

        root_node

    end

    def new_move_positions(pos)
        new_moves = KnightPathFinder.valid_moves(pos).reject { |move| considered_positions.include?(move) }
        new_moves.each { |move| considered_positions << move }
        new_moves 
    end

end

