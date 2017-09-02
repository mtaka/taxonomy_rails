require 'test/unit'
require './lib/tagspace'

include Tagspace
include Test::Unit::Assertions

t_file = './test/lib/tagspace/test_taxonomies.txt'
aa = file_to_element_arr(t_file, VBAR)

space = Space.new.build_element_array(aa)




puts space.xml_serialize

