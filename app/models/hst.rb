class Hst
  include Mongoid::Document
  
  validates_presence_of :value , :tstamp
  field :value, type: String
  field :tstamp, type: Integer
  belongs_to :atr
  attr_accessible :value , :tstamp


  def self.consultahistoricos(dia)
  @parser = Chronic.parse(dia)
  @integro = @parser.to_i
  @historicos= self.all.or(:tstamp.lte => @integro)
  return @historicos

  end	

end
