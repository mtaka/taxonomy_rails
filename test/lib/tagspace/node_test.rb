require 'test/unit'
require './lib/tagspace'

include Tagspace
include Test::Unit::Assertions



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

PQR|Themes||||themes
||Digital|||digital
|||Digital Marketing||digital_marketing
||HybridIT|||hybrid_it
|||Cloud||cloud
||Workstyle|||workstyle
|||Mobile||mobile



XYZ|Applications||||applications
||ERP|||erp
||CRM|||crm
||SFA|||sfa
||SCM|||scm
||HR|||hr
||Documentation|||documentation
EOS

taxonomies = Taxonomy.build(text_to_element_arr(src, VBAR))
taxonomies.each do |t|
  puts t.to_yaml
end

__END__
text_to_element_arr(src, VBAR).slice_before{|e|
  e.level==0
}.each do |arr|
  top = arr.shift
  taxonomy = Taxonomy.new(top)
  p taxonomy
end





