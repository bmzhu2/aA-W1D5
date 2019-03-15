class PolyTreeNode
    attr_reader :value, :parent, :children

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(new_parent)
        parent.children.delete(self) if parent
        @parent = new_parent
        new_parent.children << self if parent
    end

    def add_child(child_node)
        child_node.parent = self 
    end

    def remove_child(child_node)
        if children.include?(child_node)
            child_node.parent = nil
        else
            raise exception
        end
    end

    def dfs(target_value)
        return self if value == target_value

        children.each do |child|
            search_result = child.dfs(target_value)
            return search_result if search_result
        end

        nil
    end

    def bfs(target_value)
        return self if value == target_value

        queue = @children

        until queue.empty?
            current_node = queue.shift

            return current_node if current_node.value == target_value

            queue += current_node.children
        end
        nil
    end

end