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
      if filter.filter_attribute.present?
        unless filter.valid?
          errors.add(:filters, "El filtro con nombre: #{filter.name_attribute} es invalido ")
        end
      end
    end
  end


  def self.update_attributes(report_configurator, params)
    report_configurator.variable_atr = params.variable_atr
    report_configurator.filters.each do |filter|
      if params.filters.present?
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
    end
    return report_configurator
  end


  def self.find_values_filters(filters, variable_atr)

    values_tstamp = Array.new
    first_filter = nil

    filters.each do |filter|

      if filter.filter_attribute.present?

       if  first_filter.present? && values_tstamp.present?   #van por rango de tiempos

        if filter.less_to.present? && filter.higher_to.present?
          hst =  AtrHst.by_attr_and_value(filter.associated_attribute , ([{:value.gt => filter.higher_to, :value.lt => filter.less_to , :tstamp.in => values_tstamp}]).to_a)
        end

        if filter.equal_to.present?
          hst = AtrHst.by_attr_and_value(filter.associated_attribute, ([{:value => filter.equal_to , :tstamp.in => values_tstamp }]).to_a )
        end

        if filter.different_to.present?
          hst = AtrHst.by_attr_and_value(filter.associated_attribute, ([{:value.ne => filter.different_to , :tstamp.in => values_tstamp }]).to_a )
        end

      end

      if !first_filter.present?

        first_filter = filter.associated_attribute.to_s

        if filter.less_to.present? && filter.higher_to.present?
          hst =  AtrHst.by_attr_and_value(filter.associated_attribute , ([{:value.gt => filter.higher_to, :value.lt => filter.less_to}]).to_a)
        end

        if filter.equal_to.present?
          hst = AtrHst.by_attr_and_value(filter.associated_attribute, ([{:value => filter.equal_to}]).to_a )
        end

        if filter.different_to.present?
          hst = AtrHst.by_attr_and_value(filter.associated_attribute, ([{:value.ne => filter.different_to}]).to_a )
        end

      end

      if hst.present?
        values_tstamp.clear
        values_tstamp = capture_values_array(hst)
        hst.clear
      else
        values_tstamp.clear
        break
      end

    end

  end


    #consultas para determinar los valores de los filtros
    if values_tstamp.blank?

      @hst_variable_atr = AtrHst.atr_hst_only_variable_atr(variable_atr)
    else

      @hst_variable_atr = AtrHst.atr_hst_variable_atr(variable_atr, values_tstamp)
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



