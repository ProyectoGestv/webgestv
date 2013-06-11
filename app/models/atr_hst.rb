class AtrHst
  include Mongoid::Document
  field :value, type: String
  field :tstamp, type: Integer
  belongs_to :atr
  accepts_nested_attributes_for :atr
  attr_accessible :value, :tstamp, :atr
end
