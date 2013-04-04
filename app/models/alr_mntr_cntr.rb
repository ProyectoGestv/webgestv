# -*- encoding : utf-8 -*-
class AlrMntrCntr < AlrMntr
  field :value, type: Integer
  embedded_in :atr, inverse_of: :qos_mon
  embedded_in :atr, inverse_of: :alr_mon
end
