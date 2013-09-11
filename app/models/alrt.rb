class Alrt
  include Mongoid::Document
  field :title, type: String
  field :msg, type: String
  field :tipo, type: String, default: 'notif'
  field :tstamp_ini, type: Integer
  field :tstamp_last, type: Integer
  field :count, type: Integer
  field :state, type: String, default: 'noAtt'
  belongs_to :mcr_atr
  belongs_to :atr
  belongs_to :user
  embeds_one :alrt_sol
end
