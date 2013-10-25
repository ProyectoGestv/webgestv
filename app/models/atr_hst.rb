class AtrHst
  include Mongoid::Document
  
  validates_presence_of :value , :tstamp
  field :value , type:String
  field :tstamp, type:Integer
  belongs_to :atr
  attr_accessible :value , :tstamp

  scope :by_mcr_attr_and_ts, lambda{|mcr_attr_id, ts| where(:atr_id.in => McrAtr.find_by(id: mcr_attr_id).atrs.map(&:id), tstamp: ts)}
  scope :by_mcr_attr_and_ts_range, lambda{|mcr_attr_id, below_ts, above_ts| where(:atr_id.in => McrAtr.find_by(id: mcr_attr_id).atrs.map(&:id), :tstamp.gte => below_ts, :tstamp.lte => above_ts)}


  scope :by_attr_and_value_range, lambda{|attr_id, below_ts, above_ts| where(:atr_id => Atr.find_by(id: attr_id), :value.gt => below_ts.to_i, :value.lt => above_ts.to_i )}
  scope :by_attr_and_value_equal, lambda{|attr_id, equal_to| where(:atr_id => Atr.find_by(id: attr_id), :value => equal_to)}
  scope :by_attr_and_value_different, lambda{|attr_id, equal_to| where(:atr_id => Atr.find_by(id: attr_id), :value => equal_to)}

  def self.calcularestadisticos(historicos)
  @todosdatos = historicos
  @arraydatos= Array.new
  @todosdatos.each do |variable|
  @arraydatos.push(variable.value.to_i)
  end
  @estadisticos = DescriptiveStatistics::Stats.new(@arraydatos)
  return @estadisticos
  end
  

  def self.tstamptiemporeal(tstamp , atributo)
    @historico = self.where( :tstamp.gt => tstamp , :atr_id => atributo).sort({tstamp: -1}).last
    return @historico
  end

  def self.tstampultimohistorico(atributo)

    @historico = self.where(:atr_id => atributo).sort({tstamp: 1}).last
    return @historico

  end


  def self.consultarhistoricos(reporte)

  case reporte.option.to_i

    when 1

    @parserfechaa = Chronic.parse(reporte.fechaa , :endian_precedence => :little).to_i
    @parserfechab = Chronic.parse(reporte.fechab , :endian_precedence => :little).to_i
    @historicos = self.where(:atr_id => reporte.atrsim ,:tstamp.gte => @parserfechaa, :tstamp.lte => @parserfechab).sort({tstamp: 1})

    when 2


      case reporte.time.to_i

        when 1

        @consulta = "last year"

        when 2

        @consulta = "last month"

        when 3

        @consulta = "last week"

        when 4

        @consulta = "last day"

        when 5

        @consulta = "last hour"

        else

        @consulta = "last minute"

      end

      @parser = Chronic.parse(@consulta).to_i
      @historicos = self.where(:atr_id => reporte.atrsim  , :tstamp.gte => @parser).sort({tstamp: 1})
      else

      @historicos = self.where(:atr_id => reporte.atrsim ).sort({tstamp: 1})
      end

   return @historicos

  end


  #################################   consultas para realizar el "monitor de parametros compuestos" ####################################


end
