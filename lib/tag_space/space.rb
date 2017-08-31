require 'builder/xmlmarkup'

module TagSpace
  class Space
    attr_reader :reg, :taxonomies
    def initialize
      @reg, @taxonomies = [], []
    end
    def set_reg reg; @reg=reg; self; end
    def to_h include_reg=false, label_value_only=false
      hash = {
        taxonomies: @taxonomies.map{|tax| tax.to_h(label_value_only) }
      }
      if include_reg
        hash[:reg] = @reg
      end
      hash
    end
    def to_json include_reg=false, label_value_only=false
      JSON.generate(to_h(include_reg, label_value_only))
    end
    def to_yaml include_reg=false, label_value_only=false
      to_h(include_reg, label_value_only).to_yaml
    end

    def to_xml
      ret = ''
      xml = Builder::XmlMarkup.new(target: ret, indent: 2)
      xml.instruct!
      xml.TagSpace {
        xml.taxonomies {
          @taxonomies.each do |tax|
            xml.taxonomy {
              xml.index(tax.index)
              xml.label(tax.label)
              xml.value(tax.owner)
              xml.level(tax.level)
              xml.children {
                puts tax.children.size
                tax.children.each do |ch|
                  xml << ch.to_xml(4)
                end
              }
            }
          end
        }
      }
      ret
    end
  end
end



