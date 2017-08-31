require 'forwardable'
require 'json'
require 'yaml'

module TagSpace
  class Node
    extend Forwardable

    delegate [:label, :value, :index, :level, :owner] => :@element

    attr_reader :element, :children
    def initialize element=nil
      @element, @children = element, []
    end

    def build elements, level
      #top = Node.new(sub_arr.shift).build(sub_arr, 1)
      elements.slice_before{|e|
        e.level == level
      }.each do |sub_arr|
        top = sub_arr.shift
        ch  = Node.new(top)
        ch  = ch.build(sub_arr, level+1)
        self.children << ch
      end
      self
    end

    def to_h label_value_only=false
      hash = { label: label, value: value}
      unless label_value_only
        hash[:index] = index
        hash[:level] = level
        hash[:owner] = owner
      end
      if @children.size > 0
        hash[:children] = @children.map{|ch|ch.to_h(label_value_only)}
      end
      hash
    end

    def to_json label_value_only=false
      JSON.generate(to_h(label_value_only))
    end

    def to_yaml label_value_only=false
      to_h(label_value_only).to_yaml
    end

    def to_xml margin
      ret = ''
      xml = Builder::XmlMarkup.new(target: ret, indent:2, margin: margin)
      xml.node {
        xml.index(self.index)
        xml.label(self.label)
        xml.value(self.value)
        if @children.size > 0
          xml.children {
            @children.each do |ch|
              xml << ch.to_xml(margin+2)
            end
          }
        end
      }
      ret
    end
  end
end

