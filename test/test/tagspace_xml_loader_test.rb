require 'test/unit'
require './lib/tag_space'

include TagSpace
include Test::Unit::Assertions

file = './test/test/test_taxonomies.xml'

class Element
  def self.from_xml(e)
    value = e.xpath('value')
    if value
      value = value.text
      level = e.xpath('level').text.to_i
      index = e.xpath('index').text.to_i
      label = e.xpath('label').text
      owner = e.xpath('owner').text
      Element.new(index, level, label, value, owner)
    else
    end
  end
end
class Node
  def self.from_xml e
    node = Node.new(Element.from_xml(e))
    e.xpath('children/node').each do |ch|
      node.children << Node.from_xml(ch)
    end
    node
  end
end


require 'nokogiri'
doc = File.open(file){|f|Nokogiri::XML(f)}
doc.xpath('//taxonomy').each do |tax|
  puts Node.from_xml(tax).to_yaml
end


__END__
loader=XmlLoader.new.load_xml_file(file)
space = loader.gen_space
puts space.to_yaml(false, false)



