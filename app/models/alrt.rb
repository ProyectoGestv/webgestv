class Alrt
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :msg, type: String
  field :tipo, type: String, default: 'notif'
  belongs_to :mcr_atr
  belongs_to :atr
end
