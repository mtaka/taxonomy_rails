require 'forwardable'

module Tagspace
  class Node
    extend Forwardable

    delegate [:label, :value, :index, :level, :owner] => :@element
    def initialize element=nil
      @element = element
      @children = []
    end
    def build elements, level
      return self if elements.size==0
      elements.slice_before{|e|
        e.level == level
      }.each do |sub_arr|
        @children << Node.new(sub_arr.shift).build(sub_arr, level+1)
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
