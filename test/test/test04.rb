
module TaxonomyClassify
  CR, TAB, SPC, SP2 = "\n", "\t", ' ', '  '
  def open_file path
    open(path, 'r:utf-8')
  end
  def do_stream en
    en.each_with_index do |line, i|
      yield line, i
    end
  end
  def do_file path
    do_stream(open(path, 'r:utf-8')) do |line, i|
      yield line, i
    end
  end
  def lines2matrix en, rs, re, cs=0
    rr = re-rs
    en.drop(rs-1).take(rr).map{|a|
      a.split(TAB).drop(cs).to_a
    }.to_a
  end
  def matrix_levels aa
    aa.map{|a|
      a.each_with_index.select{|e, i| e != '' }.map{|e, i| [e, i]}
    }
  end
  IndexLevelPair = Struct.new(:index, :level)
  class Node
    attr_reader :key, :body, :children
    def initialize key=nil, body=nil
      @key, @body = key, body
      @children=[]
    end
    def indent str, level
      "#{SP2 * level}#{str}"
    end
    def build en, level=0
      en.slice_before{|e|
        e.first == level
      }.each do |a|
        top = a.shift
        ch = Node.new(top.last)

        ch = ch.build(a, level+1) if a.size > 0

        self.children << ch
      end
      self
    end
    def desc level=0
      puts indent(key, level)
      children.each do |ch|
        ch.desc level+1
      end
    end
  end
  KeywordEntry = Struct.new(:index, :keyword, :level, :parent)
  def create_keyword_matrix aa
    aa.map{|a|
      a.each_with_index.select{|e,i|
        e != ''
      }.map{|e,i|
        KeywordEntry.new(i, e)
      }
    }
  end
end


include TaxonomyClassify

file = ARGV.shift
m = lines2matrix(open_file(file), 2, 7, 2) 
mm =  matrix_levels(m.transpose)
mm.pop

levels = mm.map{|a|a.flatten.last}




# with index, except nil
en = levels.each_with_index.select{|e,i|e!=nil}

#root = build(en, Node.new)
root = Node.new.build(en)
#p root
root.desc






