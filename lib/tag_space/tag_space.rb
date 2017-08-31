module TagSpace
  CR, TAB = "\n", "\t"
  VBAR, COMMA, COMMA_SP = '|', ',', ', '
  COLON, COLON_SP, SEMICOLON, SEMICOLON_SP = ':', ': ', ';', '; '
  SPC, SPCS = ' ', '  '
  
  def indent str, level=0
    [SPCS*level, str].join
  end

  def get_value_level arr
    value_level_pair = arr.each_with_index.select{|e, i|
      e != ''
    }.flatten
    value_level_pair==[] ? nil : value_level_pair
  end

  Element = Struct.new(:index, :level, :label, :value, :owner) do
    def desc
      [label, value, index, level, owner].join(COLON)
    end
    def self.create(index:, label:, value:, level: 0, owner: '')
      Element.new(index, level, label, value, owner)
    end
    def self.from_arr(index, arr)  # [owner, [labels], value] assumed
      owner = arr.shift
      value = arr.pop
      (label, level) = get_value_level(arr)
      #p [index, level, label, value, owner]
      if value and value!=''
        Element.new(index, level, label, value, owner)
      else
        nil
      end
    end
  end
end
