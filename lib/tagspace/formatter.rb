require 'json'
require 'yaml'

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
  end
end
