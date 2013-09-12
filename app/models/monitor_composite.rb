class Monitor_composite

  include ActiveAttr::Model


  attribute :manrsc
  attribute :paracom
  attribute :monitors_atr_composite
  attribute :atr_variable
  attr_accessor :manrsc , :paracom , :atr_variable


  def monitor_atr_composite_attributes=(attr)
    attr.each do |mon_atr_composite|
      mon_atr_composite << Monitor_atr_composite.new(attr)
    end
  end



end