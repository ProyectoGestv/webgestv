class Alrt
  include Mongoid::Document
  field :title, type: String
  field :msg, type: String
  field :tipo, type: String, default: 'notif'
  field :tstamp, type: Integer
  belongs_to :mcr_atr
  belongs_to :atr
end
