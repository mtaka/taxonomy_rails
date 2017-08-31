require 'test/unit'
require './lib/tag_space'

include TagSpace
include Test::Unit::Assertions

file = './test/test/test_taxonomies.xml'

loader=XmlLoader.new.load_xml_file(file)
space = loader.gen_space
puts space.to_yaml(false, false)



