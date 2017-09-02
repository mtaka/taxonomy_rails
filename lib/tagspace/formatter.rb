require 'json'
require 'yaml'
require 'builder/xmlmarkup'

module Tagspace
  module Formattable
    def to_json; JSON.generate(self.to_h); end
    def to_yaml; self.to_h.to_yaml; end
  end
  class Element
    extend Formattable
  end
  class Node
    extend Formattable
    def to_xml margin
      ret = ''
      xml = Builder::XmlMarkup.new(target: ret, indent: 2, margin: margin)
      xml.Tag(index: self.index) {
        xml.label self.label
        xml.value self.value
        xml.owner self.owner
        xml.level self.level
        if @children.count > 0
          xml.children {
              @children.each do |ch|
                xml << ch.to_xml(margin+2)
              end
          }
        end
      }
      ret
    end
  end
  class Taxonomy
    def to_xml
      ret = ''
      xml = Builder::XmlMarkup.new(target: ret, indent: 2, margin: 2)
      xml.Taxonomy(index: self.index) {
        xml.name self.label
        xml.id self.value
        xml.owner self.owner
        xml.level self.level
        xml.tags {
          @children.each do |ch|
            xml << ch.to_xml(4)
          end
        }
      }
      ret
    end
  end

  class Space
    def xml_serialize title='', description='', notes=''
      ret = ''
      xml = Builder::XmlMarkup.new(target: ret, indent: 2)
      xml.TagSpace {
        xml.title title
        xml.description description
        xml.notes notes
        xml.taxonomies {
          @taxonomies.each do |t|
            xml << t.to_xml
          end
        }
      }
      ret
    end
  end
end
