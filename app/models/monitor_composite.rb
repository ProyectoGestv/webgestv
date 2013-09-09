class Monitor_composite

  include ActiveAttr::Model


  attribute :manrsc
  attribute :paracom
  attr_accessor :manrsc, :paracom
  validates_presence_of :manrsc



end