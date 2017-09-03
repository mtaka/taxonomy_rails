class Taxonomy < ApplicationRecord
  def to_h
    {
      name: self.name,
      body: build_body.to_h
    }
  end
  def build_body
    loader = Tagspace::XmlLoader.new.load(self.body)
    space  = loader.build_space
  end
end
