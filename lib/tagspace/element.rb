module Tagspace
  def detect_label_index (arr, f=lambda{|v|v!=nil && v.strip!=''})
    arr.each_with_index.select{|e,i|f.call(e)}.flatten
  end
  def text_to_matrix (src, fs=TAB)
    src.lines.each_with_index.map{|line,i| [i, line.chop.split(fs)] }
  end
  def text_to_element_arr (src, fs=TAB)
    text_to_matrix(src, fs).map{|i,arr|
      e =Element.from_arr(i, arr)
    }.select{|e| e!= nil}
  end
  def file_to_matrix (path, fs=TAB)
    text_to_matrix(open(path).read, fs)
  end
  def file_to_element_arr (path, fs=TAB)
    text_to_element_arr(open(path).read, fs)
  end

  class Element 

    attr_reader :index, :label, :value, :level, :owner

    def initialize index, label, value, level, owner=''
      @index, @label, @value, @level, @owner = index, label, value, level, owner
    end
    def self.create(index:, label:, value:, level:, owner: '')
      Element.new(index, label, value, level, owner)
    end
    def self.from_hash(hash)
      Element.new(hash[:index], hash[:label], hash[:value], hash[:level], hash[:owner])
    end
    def self.from_arr(index, arr)
      owner = arr.shift
      value = arr.pop
      if value and value!=''
        label, level = detect_label_index(arr)
        Element.new(index, label, value, level, owner)
      else
        nil
      end
    end
    def self.from_text(index, src, sp=CMM)
      self.from_arr(index, src.split(sp))
    end
    def to_h
      {index: index, label: label, value: value, level: level, owner: owner}
    end
  end
end
