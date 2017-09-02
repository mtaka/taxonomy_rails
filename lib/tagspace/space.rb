module Tagspace
  class Space
    attr_reader :taxonomies, :refs
    def initialize
      @taxonomies, @refs = [], {}
    end
    def build_element_array e_arr
      taxonomy  = Taxonomy.new.build_element_array(e_arr, 0) do |n|
        @refs[n.index] = n
      end
      self
    end
  end
end
