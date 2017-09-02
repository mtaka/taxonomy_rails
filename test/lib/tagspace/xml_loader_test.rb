require 'test/unit'
require './lib/tagspace'
require './lib/tagspace/xml_loader'

include Tagspace
include Test::Unit::Assertions

xml_file = './test/lib/tagspace/test_taxonomies_result.xml'
loader = XmlLoader.new.load_file(xml_file)
loader.build_space.taxonomies.each do |tax|
  puts tax.to_yaml
end

#loader.taxonomies.each do |t|
  #puts t.to_yaml
#end




