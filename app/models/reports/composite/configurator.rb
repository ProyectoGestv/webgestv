class Reports::Composite::Configurator

  include ActiveAttr::Model


  attribute :variable_atr
  attribute :filters
  attr_accessor  :variable_atr, :filters

  validates_presence_of :variable_atr , message: "debe seleccionar uno"

  def filters_attributes=(filters)
    @filters = []
    filters.keys.each do |index|
     @filters << Reports::Composite::Filter.new(filters[index])
    end
  end


  def self.find_values_variable_atr(variable_atr)
   @variable_atr = Atr.find_by(id: variable_atr)
   return @variable_atr
  end

  def self.find_values_filters(filters)

  values_tstamp = []

  filters.each do |filter|

  puts filter.associated_attribute

  #consultas aqui :S

  end

  end

end
