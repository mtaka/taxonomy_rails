require 'forwardable'

module Tagspace
  class Node
    extend Forwardable

    delegate [:label, :value, :index, :level, :owner] => :@element

    attr_reader :element, :children

    def initialize element=nil
      @element = element
      @children = []
    end

    def build_element_array elements, level, &block
      return self if elements.size==0
      elements.slice_before{|e|
        e.level == level
      }.each do |sub_arr|
        #ch = Node.new(sub_arr.shift).build_element_array(sub_arr, level+1, &block)
        ch = Node.new(sub_arr.shift)
        yield ch if block_given?
        ch = ch.build_element_array(sub_arr, level+1, &block)
        @children << ch
      end
      self
    end

    def to_h
      hash = {label: label, value: value, index: index, level: level, owner: owner}
      if @children.size > 0
        hash[:children] = @children.map{|ch|ch.to_h}
      end
      hash
    end
  end
end
