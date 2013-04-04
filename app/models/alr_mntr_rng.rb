class AlrMntrRng < AlrMntr
  field :cat, type: String
  field :value_up, type: Integer
  field :value_down, type: Integer
  embedded_in :atr
end