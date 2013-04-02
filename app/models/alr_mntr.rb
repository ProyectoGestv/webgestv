class AlrMntr
  include Mongoid::Document
  field :descr, type: String
  field :type, type: String
  field :state, type: String
  field :impact, type: String
  embedded_in :atr, :mcr_atr
end
