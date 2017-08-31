require 'test/unit'
require './lib/tag_space'

include TagSpace
include Test::Unit::Assertions

# Generation test
e = Element.new(10, 2, 'E1', 'e1', 'OWNER')
n = Node.new(e)
assert_equal n.element, e
assert_equal e.label, n.label
assert_equal e.value, n.value
assert_equal e.index, n.index
assert_equal e.level, n.level
assert_equal e.owner, n.owner

# Building test
elements = [
  Element.new(10, 0, 'E', 'e', 'OWNER'),
  Element.new(11, 1, 'E1', 'e1', ''),
  Element.new(12, 2, 'E11', 'e11', ''),
  Element.new(13, 2, 'E12', 'e12', ''),
  Element.new(14, 1, 'E2', 'e2', ''),
  Element.new(15, 2, 'E21', 'e21', ''),
  Element.new(16, 2, 'E22', 'e22', ''),
]

top = elements.shift
root = Node.new(top).build(elements, 0)
assert_equal root.children.size, 1
assert_equal root.children.first.children.size, 2
assert_equal root.children.first.children.last.label, 'E2'

puts root.to_json
puts root.to_yaml
puts root.to_json(true)
puts root.to_yaml(true)



