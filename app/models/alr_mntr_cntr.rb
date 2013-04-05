# -*- encoding : utf-8 -*-
class AlrMntrCntr < AlrMntr
  field :value, type: Float
  embedded_in :atr, inverse_of: :qos_mon
  embedded_in :atr, inverse_of: :alr_mon
  validates_presence_of :value, message: 'El umbral no puede estar vacío'
  validates_numericality_of :value, :only_integer => false, :allow_nil => false,
                            :message => "Umbral debe ser un número entero o decimal (ej. 3.1416)."
end
