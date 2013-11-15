class Reports::Composite::Filter

  include ActiveAttr::Model
  include ActiveAttr::MassAssignment

  attribute :associated_attribute
  attribute :filter_attribute
  attribute :equal_to
  attribute :different_to
  attribute :higher_to
  attribute :less_to
  attribute :name_attribute
  attribute :tipo_attribute

  attr_accessor  :tipo_attribute , :filter_attribute , :equal , :different_to , :higher_to , :less_to , :name_attribute , :associated_attribute


  validate :validate_presence_filter


def validate_presence_filter

   if filter_attribute !=0

    if less_to == nil && higher_to == nil &&  equal_to == nil && different_to == nil
     errors.add(:less_to, 'no has proporcionado ningun valor al filtro')
    end

    if less_to != nil && higher_to != nil
      errors.add(:less_to,' menor que: este valor debe ser mayor') if less_to < higher_to
    end

    if less_to == nil && higher_to != nil
      errors.add(:less_to,' menor que: este valor debe ser indicado')
    end
    if higher_to == nil   && less_to != nil
    errors.add(:higher_to,'mayor que: este valor debe ser indicado')
    end

   if (less_to != nil || higher_to != nil || different_to != nil) && equal_to != nil
     errors.add(:equal_to , 'unicamente debe proporcionar un parametro (igual o diferente) o rango')
   end

   if (less_to != nil || higher_to != nil || equal_to != nil) && different_to != nil
     errors.add(:different_to , 'unicamente debe proporcionar un parametro (igual o  diferente)  o rango')
   end

   end

end



end