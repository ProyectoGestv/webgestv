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


  # encontramos los valores del atributo variable

  def self.find_values_variable_atr(variable_atr)
   @variable_atr = Atr.find_by(id: variable_atr)
   return @variable_atr
  end



  # encontrar los valores de los filtros en un array

  def self.find_values_filters(filters)
  values_tstamp = []
  filters.each do |filter|

  puts 'atributo asociado'
  puts filter.associated_attribute

  if (filter.less_to && filter.higher_to)
   @hsts_rank =   AtrHst.by_attr_and_value_range(filter.associated_attribute , filter.higher_to , filter.less_to)
   puts 'historicos:'
   puts @hsts_rank.as_json
   filter_rank = []
   @hsts_rank.each do |hst|
     filter_rank << hst.tstamp
   end
   values_tstamp << filter_rank
  end

  if (filter.equal_to)
    @hsts_equal = AtrHst.by_attr_and_value_equal(filter.associated_attribute , filter.equal_to)
    puts 'historicos:'
    puts @hsts_equal.as_json
    filter_equal = []
    @hsts_equal.each do |hst|
      filter_equal << hst.tstamp
    end
    values_tstamp << filter_equal
  end


  puts 'values_tstamp'
  puts values_tstamp

  #consultas para determinar los valores de los filtros

  end

  end

end
