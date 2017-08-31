

module TaxonomyClassify
  require 'json'

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
  def indent str, level=0
    [SP2*level, str].join
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

  class TaxonomySpace
    attr_reader :keyword_ref, :keyword_entries, :taxonomies
    KeywordEntry = Struct.new(:index, :term, :level) do
      def desc; [self.index, self.term, self.level].join(' / ') end
    end
    class TaxonomyNode
      attr_reader :name, :index, :children
      #def initialize name, index
      def initialize ke
        @name  = ke.term
        @index = ke.index
        @children = []
      end
      def build ke_arr, level=0
        ke_arr.slice_before{|ke|
          ke.level == level
        }.each do |sub_arr|
          top = sub_arr.shift
          ch  = TaxonomyNode.new(top)
          ch  = ch.build(sub_arr, level+1) if sub_arr.size > 1
          @children << ch
        end
        self
      end
      def info
        [@name, @index].join('/')
      end
      def desc level=0
        ret = []
        ret << indent(info, level)
        self.children.each do |ch|
          ret << ch.desc(level+1)
        end
        ret.join(CR)
      end
      def to_lv_pair
        ret = { label: @name, value: @index }
        if @children.size > 0
          ret[:children] = @children.map{|ch|ch.to_lv_pair}
        end
        ret
      end
    end
    class Taxonomy < TaxonomyNode
      def build ke_arr
        super ke_arr
      end
    end
    def init aa
      @keyword_ref = []
      @keyword_entries = aa.each_with_index.map{|a, r|
        e, c = a.each_with_index.select{|e,c|
          e != ''
        }.flatten
        @keyword_ref[r] = e
        c ? KeywordEntry.new(r, e, c) : nil
      }.select{|ke|
        ke != nil
      }
      self
    end
    def build_taxonomy
      @taxonomies = @keyword_entries.slice_before{|ke|
        ke.level == 0
      }.map{|b|
        e = b.shift
        TaxonomyNode.new(e).build(b, 1)
      }
      self
    end
    def to_lv_pair
      @taxonomies.map{|t|t.to_lv_pair}
    end
    def select_keywords *indices
      @keyword_ref.values_at(*indices)
    end
    def select_keywords_str sp=', ', *indices
      select_keywords(*indices).join(sp)
    end
  end

end


include TaxonomyClassify

file = ARGV.shift
m = lines2matrix(open_file(file), 2, 7, 2).transpose
m.pop
t = TaxonomySpace.new.init(m).build_taxonomy
#t.taxonomies.each do |tx|
  #puts tx.desc
#end
puts JSON.generate(t.to_lv_pair)
#puts t.keyword_ref.values_at(192, 193, 194)
puts t.select_keywords_str('|', 192, 193, 194)





