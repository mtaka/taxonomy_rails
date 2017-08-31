require 'test/unit'
require './lib/tag_space'

include TagSpace
include Test::Unit::Assertions

puts indent('aa', 2)

e = Element.new(10, 2, 'E1', 'e1', 'OWNER')
puts e.desc
assert_equal e.desc, 'E1:e1:10:2:OWNER'

assert_equal get_value_level(['A', '', '', '']), ['A', 0]
assert_equal get_value_level(['', 'a', '', '']), ['a', 1]
assert_equal get_value_level(['', '', 'a1', '']), ['a1', 2]
assert_equal get_value_level(['', '', '', 'c10']), ['c10', 3]
assert_equal get_value_level(['', '', '', '']), nil

e = Element.from_arr(10, ['OWNER', 'A', '', '', '', 'a'])
p e
assert_equal e.index, 10
assert_equal e.owner, 'OWNER'
assert_equal e.label, 'A'
assert_equal e.level, 0
assert_equal e.value, 'a'

e = Element.from_arr(15, ['OWNER1', '', '', 'aa', '', 'ab'])
p e
assert_equal e.index, 15
assert_equal e.owner, 'OWNER1'
assert_equal e.label, 'aa'
assert_equal e.level, 2
assert_equal e.value, 'ab'



