class FormReportAtrComposite

  include ActiveAttr::Model

  attribute :atributte
  attribute :filter
  attribute :equal_to
  attribute :different_to
  attribute :higher_to
  attribute :less_to
  attribute :name
  attr_accessor :filter , :equal , :different , :higher , :less , :name , :atributte

  def self.atributte=(atribut)
    :atributte << atribut
  end

end