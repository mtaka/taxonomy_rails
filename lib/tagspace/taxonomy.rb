module Tagspace
  class Taxonomy < Node
    def self.build elements
      elements.slice_before{|e|
        e.level == 0
      }.map{|sub_arr|
        Taxonomy.new(sub_arr.shift).build(sub_arr, 1)
      }
    end
  end
end
