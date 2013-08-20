class Composite
  include ActiveAttr::Model

  attribute :paracomp
  attribute :atrcomp
  attribute :datostabla
  attribute :option
  attribute :time
  attribute :inf_id ,:type => Array
  attribute :sup_id
  attribute :igual_id
  attribute :dif_id


  attr_accessible :paracomp, :atrcomp
  validates_presence_of :paracomp
  validates_presence_of :atrcomp
  validates_presence_of :time ,:if => :rango_tiempo?  ,  message: "debe seleccionar uno"

  def rango_tiempo?
    option == '2'
  end

  def rango_fechas?
    option == '1'
  end
end