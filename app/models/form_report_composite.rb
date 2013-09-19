class FormReportComposite

  include ActiveAttr::Model


  attribute :manrsc
  attribute :paracom
  attribute :form_report_composite_attrs
  attribute :atr_variable
  attr_accessor :manrsc , :paracom , :atr_variable , :atr_variable , :form_report_composite_attrs

  def self.form_report_composite_attrs=(attrs)
    attrs.each do |attr|
      :form_report_composite_attrs << attr
    end
  end



end