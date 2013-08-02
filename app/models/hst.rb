class Hst
  include Mongoid::Document
  
  validates_presence_of :valuee , :tstamp
  field :valuee, type:String
  field :tstamp, type:Integer
  belongs_to :atr
  attr_accessible :valuee , :tstamp


  def self.calcularestadisticos(historicos)
  @todosdatos = historicos
  @arraydatos= Array.new
  @todosdatos.each do |variable|
  @arraydatos.push(variable.valuee.to_i)
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

    @parserfechaa = Chronic.parse(reporte.fechaa).to_i
    @parserfechab = Chronic.parse(reporte.fechab).to_i
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




end
