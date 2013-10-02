class Reports::Composite::Configurator

  include ActiveAttr::Model


  attribute :variable_atr
  attribute :filters
  attr_accessor  :variable_atr, :filters


  def filters_attributes=(filters)
    @filters = []
    filters.keys.each do |index|
     @filters << Reports::Composite::Filter.new(filters[index])
    end
  end

end
