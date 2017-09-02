module Tagspace
  class Space
    attr_reader :taxonomies, :refs
    def initialize
      @title, @description, @notes = '', '', ''
      @taxonomies, @refs = [], {}
    end
    def build_element_array elements
      elements.slice_before{|e|
        e.level == 0
      }.each do |sub_arr|
        t = Taxonomy.new(sub_arr.shift).build_element_array(sub_arr, 1) do |n|
          @refs[n.index] = n
        end
        @refs[t.index] = t
        @taxonomies << t
      end
      self
    end
    def to_h
      hash = {
        refs: {
          labels: Hash[@refs.map{|k,v|[k,v.label]}],
          values: Hash[@refs.map{|k,v|[k,v.value]}]
        },
        taxonomies: @taxonomies.map{|t|t.to_h}
      }
      hash
    end
  end
end
