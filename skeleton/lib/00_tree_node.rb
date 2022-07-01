require "byebug"

class PolyTreeNode

    attr_reader :parent, :children, :value

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(node)
        # debugger
        return if self.parent == node

        if self.parent
            self.parent.children.delete(self)
        end

        @parent = node
        self.parent.children << self unless self.parent.nil?

        # if !parent.nil? 
        #     parent.children.delete(self)
        #     @parent = node 
        #     @parent.children << self if !@parent.children.include?(self)
        # else
        #     @parent = node 
        #     @parent.children << self if !@parent.children.include?(self)
        # end
    end

    def add_child(child_node)
        
        # we are adding a child to a node with this function.
        child_node.parent = self
    end

    def remove_child(child_node)
        # removing a child from a node with this function. 
        raise "node is not a child" if child_node.parent.nil? 
        child_node.parent = nil
    end

    def dfs(target) 
        return self if self.value == target
        return nil if self.children.length == 0

        self.children.each do |child|
            results = child.dfs(target) 
            return results unless results.nil? 
        end
        nil
    end

    def bfs(target)
        # get self, shovel into array. 
        # once shoveled, we itterate through the nodes children, and 
        # shovel those into the end of the array. 
        # after all children are accounted for, we pop out the first node 
        # and check its value against the targed. 
        # loop through again, checking each node, adding children, and 
        # shoveling into the array, until the value is found. 
        # return nil if the value is not there. 
        
        arr = []
        arr.unshift(self)
        while arr.length > 0
            current_node = arr.pop
            return current_node if current_node.value == target
            current_node.children.each {|child| arr.unshift(child)}
        end
        nil
    end
end

# does not have a parent

# other case, it did have a parent, and we are moving it. So before we
# reassign, we are going to have to remove it from its children. 

# have to allow for nil. So we have to be able to say, node.parent=nil