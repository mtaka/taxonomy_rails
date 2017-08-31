require 'rexml/document'

module TagSpace
  class XmlLoader
    def load_xml xml
      @doc = REXML::Document.new(xml)
      self
    end
    def load_xml_file file
      load_xml(File.new(file))
    end
    def gen_node element
      taxonomy = Node.new
      value = element['value']
      if value
        value = value.text
        index = element['index']
        index = index ? index.text.to_i : nil
        label = element['label']
        label = label ? label.text : ''
        level = element['level']
        level = level ? level.to_i : nil
        owner = element['owner']
        owner = owner ? owner.text : ''

        e = Element.create(index: index, label: label, value: value, level: level, owner: owner)
        Node.new(e)
      else
        nil
      end
    end
    def gen_space
      space = Space.new.set_reg(@reg)

      @doc.elements.each('//taxonomy') do |tax|
        p gen_node(tax)
      end

      space
    end
  end
end

