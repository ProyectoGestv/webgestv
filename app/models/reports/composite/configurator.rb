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
   array_rank =[]
   puts 'historicos:'
   puts @hsts_rank.as_json
   @hsts_rank.each do |hst|
     array_rank << hst.tstamp
   end
   values_tstamp << array_rank
  end

  if (filter.equal_to)
    @hsts_equal = AtrHst.by_attr_and_value_equal(filter.associated_attribute , filter.equal_to)
    array_equal =[]
    puts 'historicos:'
    puts @hsts_equal.as_json
    @hsts_equal.each do |hst|
      array_equal << hst.tstamp
    end
   values_tstamp << array_equal
  end

  if (filter.different_to)
    @hsts_different = AtrHst.by_attr_and_value_different(filter.associated_attribute , filter.different_to)
    array_different =[]
    puts 'historicos:'
    puts @hsts_different.as_json
    @hsts_different.each do |hst|
      array_different << hst.tstamp
    end
    values_tstamp << array_different
  end

  end


  puts 'values_tstamp'
  puts values_tstamp

  #consultas para determinar los valores de los filtros


  end

end
