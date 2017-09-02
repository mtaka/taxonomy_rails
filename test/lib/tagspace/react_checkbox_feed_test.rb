require 'test/unit'
require './lib/tagspace'
require './lib/tagspace/react_checkbox_feed'

include Tagspace
include Test::Unit::Assertions

t_file = './test/lib/tagspace/test_taxonomies.txt'
aa = file_to_element_arr(t_file, VBAR)

space = Space.new.build_element_array(aa)




puts space.react_checkbox_feed.to_json


