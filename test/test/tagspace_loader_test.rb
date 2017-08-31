require 'test/unit'
require './lib/tag_space'
#require './lib/tag_space/tag_space'
#require './lib/tag_space/loader'

include TagSpace
include Test::Unit::Assertions

aa=<<EOS.split(CR).map{|line|line.split(VBAR)}
P|ThemeA||||a
||a|||aa
|||1||aa1
|||2||aa2
|||3||aa3
||b|||ab
|||1||ab1
|||2||ab2
|||3||ab3
|||||
|||||
Q|ThemeB||||b
||1||b1
||2||b2
||3||a3
||4||a4
||5||a5
||6||a6
||7||a7
||8||a8
|||||
R|ThemeC||||c
||a|||ca
|||1||ca1
||||1|ca11
||||2|ca12
||||3|ca13
|||2||ca2
||||1|ca21
||||2|ca22
||||3|ca23
|||3||ca3
||||1|ca31
||||2|ca32
||||3|ca33
||b|||cb
|||1||cb1
|||2||cb2
|||3||cb3
EOS



loader=Loader.new.load_aa(aa)
puts loader.reg.size
puts aa.size
assert_equal loader.reg.size, aa.size

puts loader.elements.size
valid_aa = aa.select{|arr|arr.join!=''}
puts valid_aa.size
assert_equal loader.elements.size, valid_aa.size

#puts loader.gen_space.to_yaml
puts loader.gen_space.to_xml

