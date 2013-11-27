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
  validates_numericality_of :higher_to, :only_integer => false, :allow_nil => false, :message => "debe ser un número entero o decimal."
  validates_numericality_of :less_to, :only_integer => false, :allow_nil => false,:message => "cldebe ser un número entero o decimal."

def validate_presence_filter

   if filter_attribute !=0

    if !less_to.present? && !higher_to.present? &&  !equal_to.present? && !different_to.present?
     errors.add(:less_to, 'no has proporcionado ningun valor al filtro')
    end

    if less_to.present? && higher_to.present?
      errors.add(:less_to,' menor que: este valor debe ser mayor') if less_to < higher_to
    end

    if !less_to.present? && higher_to.present?
      errors.add(:less_to,' menor que: este valor debe ser indicado')
    end
    if !higher_to.present?   && less_to.present?
    errors.add(:higher_to,'mayor que: este valor debe ser indicado')
    end

   if (less_to.present? || higher_to.present? || different_to.present?) && equal_to.present?
     errors.add(:equal_to , 'unicamente debe proporcionar un parametro (igual o diferente) o rango')
   end

   if (less_to.present? || higher_to.present? || equal_to.present?) && different_to.present?
     errors.add(:different_to , 'unicamente debe proporcionar un parametro (igual o  diferente)  o rango')
   end

   end

end



end