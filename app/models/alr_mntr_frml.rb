# -*- encoding : utf-8 -*-
class AlrMntrFrml < AlrMntr
  field :value, type: String
  embedded_in :mcr_atr, inverse_of: :alr_mon
  validates_presence_of :value, message: 'La fórmula no ppuede estar vacía'
end
