module Tagspace
  class Taxonomy < Node
=begin
    def self.from_element_array elements
      elements.slice_before{|e|
        e.level == 0
      }.each do |sub_arr|
        taxonomy = Taxonomy.new(sub_arr.shift).build_element_array(sub_arr, 1) do |t|
          yield t if block_given?
        end
      end
    end
=end
  end
end
