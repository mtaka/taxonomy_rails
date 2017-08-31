#!/usr/local/bin/ruby

module TaxonomyBuilder
  CR, TAB = "\n", "\t"
  #R_OWNER, R_ROOT, R_TREES, R_KW, R_RES_START = 0, 1, 2...7, 8, 12
  R_OWNER, R_TREES, R_KW, R_RES_START = 0, 1...7, 8, 12
  def do_stream en
    en.each_with_index do |line, i|
      yield line, i
    end
  end
  def select_value_indices arr
    arr.each_with_index.select{|e,i| e!='' && e!=nil }.map{|e,i|i}
  end
  def build_header en
    matrix = []
    en.drop(1).take(7).each do |line|
      arr = line.split(TAB)
      arr.shift(2)
      matrix << arr
    end
    fields = matrix.transpose
    indices = Array.new(fields.size, nil)
    labels  = Array.new(fields.size, '')
    fields.each_with_index do |arr, i|
      arr.each_with_index do |e, j|
        if e != ''
          indices[i] = j
          labels[i] = e
        end
      end
    end
    p labels.each_cons(2).map{|i,j| 
      i = i ? i : 0; i = i.to_i
      j = j ? j : 0; j = j.to_i
      j-i
    }
    return indices
  end

  def gen_from_stream en
    @store = {}
    @refs  = []
    @cur = nil
    do_stream en do |line, i|
      arr = line.split(TAB); arr.shift(2)
      @refs  ||= Array.new(arr.size, nil)
      case i
      when R_OWNER
      when R_ROOT
        arr.each_with_index do |e, i|
          if e != ''
            @store[e] = {}
            @cur = e
          end
          @refs[i] = [@cur]
        end
      when R_TREES
        arr.each_with_index do |e, i|
          @cur = @refs[i]
          if e != ''
            h = @store.dig(*@cur)
            h[e] = {}
            @cur << e
          end
          @refs[i] = @cur
        end
      when R_KW
      end
      i+=1
    end
    #puts store.map{|k,v| [k,v].join(' : ') }
    #puts refs.map{|e| "#{e} : #{store.dig(*e)}" }
    @refs.each do |ref|
      puts ref.join(' > ')
      puts @store.dig(*ref)
    end
  end
end

include TaxonomyBuilder

file = ARGV.shift
#headers = gen_from_stream_(open(file, 'r:utf-8'))
#headers.each do |arr|
  #puts arr.join(' > ')
#end

p build_header(open(file, 'r:utf-8'))

__END__
do_stream open(file, 'r:utf-8') do |line|
  puts line.split(TAB)
end

