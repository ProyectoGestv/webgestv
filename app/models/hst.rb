class Hst
  include Mongoid::Document
  
  validates_presence_of :value , :tstamp
  field :value, type: String
  field :tstamp, type: Integer
  belongs_to :atr
  attr_accessible :value , :tstamp

  def self.consultahistoricos(dia,atr)
  @parser = Chronic.parse(dia).to_i
  @historicos = self.where(:atr_id => atr , :tstamp.gte => @parser)
  return @historicos
  end 


  def self.calcularestadisticos(hst)
  @todosdatos = hst
  @ret= Array.new
  @todosdatos.each do |variable|
  @ret.push(variable.value.to_i)
  end
  @stats = DescriptiveStatistics::Stats.new(@ret)
  return @stats
  end
  

  def self.consultahistoricosfecha(fechaa,fechab,atr)
  
  @parserfechaa = Chronic.parse(fechaa).to_i
  @parserfechab = Chronic.parse(fechab).to_i
  @historicos = self.where(:atr_id => atr ,:tstamp.gte => @parserfechaa, :tstamp.lte => @parserfechab)
  return @historicos
  end 

end
