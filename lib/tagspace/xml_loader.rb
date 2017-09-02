require 'nokogiri'

module Tagspace
  class XmlLoader
    def load xml
      @doc = Nokogiri::XML(xml)
      self
    end
    def load_file file
      @doc = Nokogiri::XML(File.open(file))
      self
    end
    def build_space
      Space.from_xml_doc(@doc)
    end
  end
  class Node
    def self.from_xml_node(e, space); Node.new.build_from_xml_node(e, space); end
    def build_from_xml_node e, space
      @index = e.xpath('@index').text.to_i
      @label = e.xpath('label').text
      @value = e.xpath('value').text
      @level = e.xpath('level').text.to_i
      @owner = e.xpath('owner').text
      space.refs[@index] = self
      e.xpath('children/Tag').each do |t|
        @children << Node.from_xml_node(t, space)
      end
      self
    end
  end
  class Taxonomy
    def self.from_xml_node(e, space); Taxonomy.new.build_from_xml_node(e, space); end
    def build_from_xml_node e, space
      @index = e.xpath('@index').text.to_i
      @label = e.xpath('name').text
      @value = e.xpath('id').text
      @level = e.xpath('level').text.to_i
      @owner = e.xpath('owner').text
      space.refs[@index] = self
      e.xpath('tags/Tag').each do |t|
        @children << Node.from_xml_node(t, space)
      end
      self
    end
  end
  class Space
    def self.from_xml_doc(doc); Space.new.build_from_xml_doc(doc); end
    def build_from_xml_doc doc
      doc.xpath('//Taxonomy').each do |tax|
        t = Taxonomy.from_xml_node(tax, self)
        @taxonomies << t
      end
      self
    end
  end
end
