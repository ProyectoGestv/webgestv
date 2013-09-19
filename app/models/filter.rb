class Filter

  include ActiveAttr::Model

  attribute :attribute
  attribute :filter
  attribute :equal_to
  attribute :different_to
  attribute :higher_to
  attribute :less_to
  attribute :name_attribute
  attr_accessor :filter , :equal , :different_to , :higher_to , :less_to , :name_attribute , :attribute

  def self.attribute=(attribut)
    :attribute << attribut
  end

end