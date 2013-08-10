class Report

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  attr_accessor :option , :parasim , :atrsim , :time , :fechaa , :fechab


  validates_presence_of :option , message: "debe seleccionar uno"
  validates_presence_of :atrsim , message: "debe seleccionar uno"
  validates_presence_of :parasim , message: "debe seleccionar uno"
  validates_presence_of :time ,:if => :rango_tiempo?  ,  message: "debe seleccionar uno"
  validates_presence_of :fechaa ,:if => :rango_fechas? , message: "debe seleccionar una fecha"
  validates_presence_of :fechab ,:if => :rango_fechas? , message: "debe seleccionar una fecha"
  validate :integridad_fecha  , :if => :rango_fechas?

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

    fechamayor = Chronic.parse(fechab,:endian_precedence => :little).to_i
    puts(fechab)
    puts(fechamayor)
    fechamenor = Chronic.parse(fechaa,:endian_precedence => :little).to_i
    puts(fechaa)
    puts(fechamenor)
    errors.add(:fechab, "esta fecha debe ser mayor") if
        fechamenor>fechamayor

  end


end