module Tagspace
  CR, TAB = "\n", "\t"
  VBAR, SP, CMM, CLN, SMCLN = '|', ' ', ',', ':', ';'
  VBARSP, SPSP, CMMSP, CLNSP, SMCLNSP = [VBAR, SP, CMM, CLN, SMCLN].map{|s|s+' '}
end

