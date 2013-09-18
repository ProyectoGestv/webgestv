class FormReportAtrComposite

  include ActiveAttr::Model

  attribute :atr
  attribute :filter
  attribute :equal_to
  attribute :different_to
  attribute :higher_to
  attribute :less_to
  attribute :name
  attr_accessor :filter , :equal , :different , :higher , :less , :name , :atr

  def atr=(atrr)
    :atr << atrr
  end

end