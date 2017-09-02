require 'test/unit'
require './lib/tagspace'

include Tagspace
include Test::Unit::Assertions

arr = ['a', '', '', '']; label, level = detect_label_index(arr)
assert_equal label, 'a'
assert_equal level, 0
arr = ['', 'b', '', '']; label, level = detect_label_index(arr)
assert_equal label, 'b'
assert_equal level, 1
arr = ['', '', '', '']; label, level = detect_label_index(arr)
assert_equal label, nil
assert_equal level, nil

arr = ['OWNER', 'A', '', '', '', 'val']
e = Element.from_arr(11, arr)
assert_equal e.index, 11
assert_equal e.label, 'A'
assert_equal e.value, 'val'
assert_equal e.owner, 'OWNER'
assert_equal e.level, 0

src = 'Owner| | |Label| | |value'
e = Element.from_text(111, src, VBAR)
assert_equal e.index, 111
assert_equal e.label, 'Label'
assert_equal e.value, 'value'
assert_equal e.owner, 'Owner'
assert_equal e.level, 2

p e.to_h
puts e.to_json
puts e.to_yaml

src =<<EOS
ABC|Industries||||Industries
||Manufacturing|||manufacturing
|||Discrte||discrete
|||Process||process
||Distribution|||distribution
|||Wholesale||wholesale
|||Retail||retail
||Services|||services
|||Professional||professional
|||IT Services||it_services
|||Logistics||logistics
||Media/Energy|||media_and_energy
||Media|||media
||Energy|||energy
||Finance|||finance
|||Banking||banking
|||Security||security
|||Insurance||insurance
||Public|||public
|||Government||government
|||Education||education
|||Medical||medical

XYZ|Applications||||applications
||ERP|||erp
||CRM|||crm
||SFA|||sfa
||SCM|||scm
||HR|||hr
||Documentation|||documentation
EOS

=begin
text_to_element_arr(src, VBAR).each do |e|
  p e
end
=end

t_file = './test/lib/tagspace/test_taxonomies.txt'
file_to_element_arr(t_file, VBAR).each do |e|
  p e
end




