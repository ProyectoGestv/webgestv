class Report

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  attr_accessor :option , :parasim , :atrsim , :time , :fechaa , :fechab


  validates_presence_of :option
  validates_presence_of :atrsim
  validates_presence_of :parasim
  validates_presence_of :time ,:if => :rango_tiempo?
  validates_presence_of :fechaa ,:if => :rango_fechas?
  validates_presence_of :fechab ,:if => :rango_fechas?
  validate :integridad_fecha

  def rango_tiempo?
    option == '2'
  end

  def rango_fechas?
    option == '1'
  end

  def initialize(attributes = {})
  if(attributes != nil)
  attributes.each do |name, value|
      send("#{name}=", value)
  end
  end
  end

  def persisted?
    false
  end


  private
  def integridad_fecha

    fechamayor = Chronic.parse(fechab).to_i
    fechamenor = Chronic.parse(fechaa).to_i
    errors.add(:fechab, "esta fecha debe ser mayor") if
        fechamenor>fechamayor

  end


end