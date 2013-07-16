class Hst
  include Mongoid::Document
  
  validates_presence_of :valuee , :tstamp
  field :valuee, type: String
  field :tstamp, type: Integer
  belongs_to :atr
  attr_accessible :valuee , :tstamp

  def self.consultahistoricos(dia,atr)
  if dia == 'ultimo ano'
  @consulta = "last year"
  elsif dia == 'ultimo mes'
  @consulta = "last month"
  elsif dia == 'ultima semana'
  @consulta = "last week"
  elsif dia == 'ultimo dia'
  @consulta = "last day"
  elsif dia == 'ultima hora'
  @consulta = "last hour"
  else
  @consulta = "last minute"
  end

  @parser = Chronic.parse(@consulta).to_i
  @historicos = self.where(:atr_id => atr , :tstamp.gte => @parser).sort({tstamp: 1})
  return @historicos
  end


  def self.consultatodos(atr)
  @historicos = self.where(:atr_id => atr).sort({tstamp: 1})
  return @historicos
  end


  def self.calcularestadisticos(hst)
  @todosdatos = hst
  @ret= Array.new
  @todosdatos.each do |variable|
  @ret.push(variable.valuee.to_i)
  end
  @stats = DescriptiveStatistics::Stats.new(@ret)
  return @stats
  end
  

  def self.consultahistoricosfecha(fechaa,fechab,atr)
  
  @parserfechaa = Chronic.parse(fechaa).to_i
  @parserfechab = Chronic.parse(fechab).to_i
  @historicos = self.where(:atr_id => atr ,:tstamp.gte => @parserfechaa, :tstamp.lte => @parserfechab).sort({tstamp: 1})
  return @historicos
  end


  def self.tstamptiemporeal(hst , atr)
    @historico = self.where( :tstamp.gt => hst , :atr_id => atr).sort({tstamp: -1}).last
    return @historico
  end

  def self.tstampultimo(atr)

    @historico = self.where(:atr_id => atr).sort({tstamp: 1}).last
    return @historico

  end


  def self.gethst(report)


  case report.option.to_i

    when 1

    @parserfechaa = Chronic.parse(report.fechaa).to_i
    @parserfechab = Chronic.parse(report.fechab).to_i
    @historicos = self.where(:atr_id => report.atrsim ,:tstamp.gte => @parserfechaa, :tstamp.lte => @parserfechab).sort({tstamp: 1})

    when 2


      case report.time.to_i

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
      puts  ( @parser)
      @historicos = self.where(:atr_id => report.atrsim  , :tstamp.gte => @parser).sort({tstamp: 1})

  else

      @historicos = self.where(:atr_id => report.atrsim ).sort({tstamp: 1})


  end

   return @historicos

  end




end
