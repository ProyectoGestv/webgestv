class Reports::Composite::Filter

  include ActiveAttr::Model

  attribute :associated_attribute
  attribute :filter_attribute
  attribute :equal_to
  attribute :different_to
  attribute :higher_to
  attribute :less_to
  attribute :name_attribute
  attr_accessor :filter_attribute , :equal , :different_to , :higher_to , :less_to , :name_attribute , :associated_attribute



  def associated_attribute_attributes=(attributes)
    @associated_attribute = Atr.find(attributes)
  end



end