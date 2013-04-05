# -*- encoding : utf-8 -*-
class AlrMntrRng < AlrMntr
  field :value_up, type: Float
  field :value_down, type: Float
  embedded_in :atr, inverse_of: :qos_mon
  embedded_in :atr, inverse_of: :alr_mon
  validates_presence_of :value_up, message: 'El umbral superior no puede estar vacío'
  validates_presence_of :value_down, message: 'El umbral inferior no puede estar vacío'
  validates_numericality_of :value_up, :only_integer => false, :allow_nil => false,
                            :message => "Umbral superior debe ser un número entero o decimal (ej. 3.1416)."
  validates_numericality_of :value_down, :only_integer => false, :allow_nil => false,
                            :message => "Umbral inferior debe ser un número entero o decimal (ej. 3.1416)."
  validates_numericality_of :value_up, :greater_than_or_equal_to => :value_down, message: 'El umbral superior debe ser mayor o igual al umbral inferior'
end
