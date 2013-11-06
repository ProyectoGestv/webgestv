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


  validates_presence_of :variable_atr , message: "debe seleccionar un Atributo variable"
  validates_presence_of :filters
  validate :filters_validity

  def filters_validity
    if filters.empty?
      errors.add(:filters, 'You must setting up at least one filter')
    else
      filters.each do |filter|
        unless filter.valid?
          errors.add(:filters, "the filter with id: #{filter.associated_attribute.id} is invalid")
          filter.errors.messages.each {|message| puts message}
        end
      end
    end
  end
  # encontrar los valores de los filtros en un array

  def self.find_values_filters(filters , variable_atr)

  @values_tstamp = Array.new
  @data = 0
  @hst


  filters.each do |filter|

  if (filter.less_to && filter.higher_to)

     if(@data == 0)
      @hst =   AtrHst.by_attr_and_value_range(filter.associated_attribute , filter.higher_to , filter.less_to)
     end

     if (@data == 1)
     @hst =  AtrHst.by_attr_and_value_range_ts(filter.associated_attribute , filter.higher_to , filter.less_to , @values_tstamp)
     end

     puts 'historicos rango'
     puts @hst.as_json

     if (@hst != nil )
       @values_tstamp = capture_values_array(@hst)
       @data = 1
     else
       break
     end

     puts 'cambio de la variable'
     puts @data
     puts @values_tstamp
  end

  if (filter.equal_to)
    if(@data == 0)
      @hst = AtrHst.by_attr_and_value_equal(filter.associated_attribute , filter.equal_to)
    end
    if(@data == 1)
    @hst = AtrHst.by_attr_and_value_equal_ts(filter.associated_attribute , filter.equal_to , @values_tstamp)
    @values_tstamp.clear
    end

    puts 'historicos igual '
    puts @hst.as_json
    puts @data
    if (@hst != nil)
      @values_tstamp = capture_values_array(@hst)
      @data = 1
    else
      break
    end


    puts @values_tstamp

  end

  if (filter.different_to)
    if(@data == 0)
      @hst = AtrHst.by_attr_and_value_different(filter.associated_attribute , filter.different_to)
    end
    if(@data == 1)
      @hst = AtrHst.by_attr_and_value_different_ts(filter.associated_attribute , filter.different_to, @values_tstamp)
      @values_tstamp.clear
    end

    puts 'historicos diferente'
    puts @hst.as_json
    puts @data
    if (@hst != nil)
      @values_tstamp = capture_values_array(@hst)
      @data = 1
    else
      break
    end

    puts @values_tstamp


  end

  end

  puts 'values_tstamp'
  puts @values_tstamp

  #consultas para determinar los valores de los filtros

  puts 'este es mi atributo variable'
  puts variable_atr


  @hst_variable_atr = AtrHst.atr_hst_variable_atr(variable_atr , @values_tstamp )

  puts 'valores con filtro de atr variable'
  puts @hst_variable_atr.as_json
  puts @hst_variable_atr

  if(@hst_variable_atr.blank?)

   @hst_variable_atr = AtrHst.atr_hst_only_variable_atr(variable_atr)
   puts 'valores sin filtro de atr variable'
   puts @hst_variable_atr.as_json

  end

  return @hst_variable_atr

  end

  def self.capture_values_array( hsts )

    @array_hst = Array.new
    hsts.each do |hst|
    @array_hst << hst.tstamp
    end
    @array_hst.uniq!
    return @array_hst

  end


end



