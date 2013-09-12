class Monitor_atr_composite

  include ActiveAttr::Model


  attribute :filter
  attribute :variable
  attribute :equal_to
  attribute :different_to
  attribute :higher_to
  attribute :less_to
  attribute :name

  attr_accessor :filter , :variable , :equal , :different , :higher , :less , :name




end