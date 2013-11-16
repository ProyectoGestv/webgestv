class Reports::Composite::Configurator

  include ActiveAttr::Model
  include ActiveAttr::MassAssignment


  attribute :variable_atr
  attribute :filters
  attr_accessor :variable_atr, :filters

  validates_presence_of :variable_atr, message: 'debe seleccionar un Atributo variable'
  validate :filters_validity


  def filters_attributes=(filters)
    @filters = []
    filters.keys.each do |index|
      @filters << Reports::Composite::Filter.new(filters[index])
    end
  end


  def filters_validity
    filters.each do |filter|
      if (filter.filter_attribute != nil)
        unless filter.valid?
          errors.add(:filters, "El filtro con nombre: #{filter.name_attribute} es invalido ")
        end
      end
    end
  end


  def self.update_attributes(report_configurator, params)

    report_configurator.variable_atr = params.variable_atr
    report_configurator.filters.each do |filter|
      params.filters.each do |filter_param|
        if filter_param.associated_attribute.to_s == filter.associated_attribute.to_s
          filter.different_to = filter_param.different_to
          filter.equal_to = filter_param.equal_to
          filter.filter_attribute =filter_param.filter_attribute
          filter.higher_to = filter_param.higher_to
          filter.less_to = filter_param.less_to
        end
      end
    end
    return report_configurator
  end


  def self.find_values_filters(filters, variable_atr)

    @values_tstamp = Array.new
    flag = 0
    @hst

    filters.each do |filter|

      if filter.less_to && filter.higher_to

        if flag == 0
          @hst = AtrHst.by_attr_and_value_range(filter.associated_attribute, filter.higher_to, filter.less_to)
        end

        if flag == 1
          @hst = AtrHst.by_attr_and_value_range_ts(filter.associated_attribute, filter.higher_to, filter.less_to, @values_tstamp)
        end

        if @hst != nil
          @values_tstamp = capture_values_array(@hst)
          flag = 1
        else
          break
        end

        puts 'historicos rango'
        puts @hst.as_json
        puts 'bandera'
        puts flag
        puts 'array tstamp'
        puts @values_tstamp
      end


      if filter.equal_to

        if flag == 0
          @hst = AtrHst.by_attr_and_value_equal(filter.associated_attribute, filter.equal_to)
        end

        if flag == 1
          @hst = AtrHst.by_attr_and_value_equal_ts(filter.associated_attribute, filter.equal_to, @values_tstamp)
          @values_tstamp.clear
        end

        if @hst != nil
          @values_tstamp = capture_values_array(@hst)
          flag = 1
        else
          break
        end

        puts 'historicos igual a'
        puts @hst.as_json
        puts 'bandera'
        puts flag
        puts 'array tstamp'
        puts @values_tstamp

      end

      if  filter.different_to

        if flag == 0
          @hst = AtrHst.by_attr_and_value_different(filter.associated_attribute, filter.different_to)
        end

        if flag == 1
          @hst = AtrHst.by_attr_and_value_different_ts(filter.associated_attribute, filter.different_to, @values_tstamp)
          @values_tstamp.clear
        end

        if @hst != nil
          @values_tstamp = capture_values_array(@hst)
          flag = 1
        else
          break
        end

        puts 'historicos diferente a'
        puts @hst.as_json
        puts 'bandera'
        puts flag
        puts 'array tstamp'
        puts @values_tstamp

      end

    end


    #consultas para determinar los valores de los filtros

    puts 'este es mi atributo variable'
    puts variable_atr
    puts 'array_tstamp'
    puts @values_tstamp


    if @values_tstamp.blank?

      @hst_variable_atr = AtrHst.atr_hst_only_variable_atr(variable_atr)
      puts 'valores sin filtro de array de atr variable'
      puts @hst_variable_atr.as_json

    else

      @hst_variable_atr = AtrHst.atr_hst_variable_atr(variable_atr, @values_tstamp)
      puts 'valores con filtro de atr variable'
      puts @hst_variable_atr.as_json

    end

    return @hst_variable_atr

  end


  def self.capture_values_array(hsts)

    @array_hst = Array.new
    hsts.each do |hst|
      @array_hst << hst.tstamp
    end
    @array_hst.uniq!
    return @array_hst

  end


end



