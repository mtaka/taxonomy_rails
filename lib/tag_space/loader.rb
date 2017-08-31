require_relative './node'

module TagSpace
  class Loader
    attr_reader :reg, :elements
    def load_aa aa
      @reg, @elements = [], []
      # Each array is supposed to consist of [owner, [label], value]
      aa.each_with_index do |arr, i|
        @reg << nil
        element = Element.from_arr(i, arr)
        if element
          @elements << element
          @reg[i] = element
        end
      end
      self
    end
    def gen_space
      space = Space.new.set_reg(@reg)
      @elements.slice_before{|e|
        e.level == 0
      }.each do |sub_arr|
        #top = Node.new(sub_arr.shift).build(sub_arr, 1)
        #top = sub_arr.shift
        #taxonomy = Node.new(top)
        #taxonomy = taxonomy.build(sub_arr, 1)
        #space.taxonomies << taxonomy
        #space.taxonomies << Node.new(sub_arr.shift).build(sub_arr, 1)
        taxonomy = Node.new(sub_arr.shift).build(sub_arr, 1)
        space.taxonomies << taxonomy
      end
      space
    end
  end
end

