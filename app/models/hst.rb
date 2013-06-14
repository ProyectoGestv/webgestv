class Hst
  include Mongoid::Document
  
  validates_presence_of :value , :tstamp
  field :value, type: String
  field :tstamp, type: Integer
  belongs_to :atr
  attr_accessible :value , :tstamp

end
