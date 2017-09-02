module Tagspace
  class Taxonomy < Node
    def name; @label; end
    def id; @value; end
    def to_h
      {
        label: label,
        value: value,
        name: label,
        id: label,
        index: index,
        level: level,
        owner: owner,
        tags: @children.map{|ch|ch.to_h}
      }
    end
  end
end
