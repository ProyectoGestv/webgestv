class Reports::Composite::Configurator

  include ActiveAttr::Model


  attribute :variable_atr
  attr_accessor  :variable_atr , :filters


  def filters_attributes=(attributes)
       @filters = Reports::Composite::Filter.new(attributes)
  end

end