class Reports::Composite::Filter

  include ActiveAttr::Model

  attribute :associate_attribute
  attribute :filter
  attribute :equal_to
  attribute :different_to
  attribute :higher_to
  attribute :less_to
  attribute :name_attribute
  attr_accessor :filter , :equal , :different_to , :higher_to , :less_to , :name_attribute , :associate_attribute

  def self.associate_attribute=(attribut)
    :associate_attribute << attribut
  end

end