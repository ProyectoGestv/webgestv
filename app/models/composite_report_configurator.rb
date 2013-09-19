class CompositeReportConfigurator

  include ActiveAttr::Model


  attribute :management_resource
  attribute :parameter_composite
  attribute :filters
  attribute :variable_atr
  attr_accessor :management_resource , :parameter_composite , :variable_atr , :form_report_composite_attrs

  def self.filters=(attrs)
    attrs.each do |attr|
      :filters << attr
    end
  end



end