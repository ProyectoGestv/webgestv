class ReportsController < ApplicationController

=begin
 $atrr

  def index
   @opcion = params[:opcion]
   @atr = params[:atr]
   $atrr = @atr
   if @opcion == "Rango tiempo"
   @tiempo = params[:tiempo]
   @historicos=Hst.consultahistoricos(@tiempo,@atr)
   elsif @opcion == "Todos"
   @historicos = Hst.consultatodos(@atr)
   else
   @fechaa = params[:fechaa]
   @fechab = params[:fechab]
   @historicos = Hst.consultahistoricosfecha(@fechaa,@fechab,@atr)
  end   
   @stats = Hst.calcularestadisticos(@historicos)
  end

=end





  def index
  @report = Report.new
  @mcrsearch=McrAtr.where(:tipo.all => ['simple'])
  respond_to do |format|
    format.html # new.html.erb
    format.json { render json: @report }
  end

  end


  def buscaratr
    @report = Report.new
    @atrsearch= Atr.where(:mcr_atr_id => params[:mcr])
     respond_to do |format|
     #format.json {render json: @atrsearch}
     format.html { render partial: 'buscaratr' , :link => @atrsearch}
     end
  end


  def rango
   @report = Report.new
   @option = (params[:id]).to_i
   respond_to do |format|

   case @option

     when 1
       format.html { render partial: 'fechas'}
     when 2
       format.html { render partial: 'tiempo'}
     when 3
       format.html { render partial: 'hst'}
     else
      format.html { render partial: 'hst' }
   end
  end
  end


  def actualizar
  @report = Report.new(params[:report])
  respond_to do |format|
    if @report.valid?
      format.html { render partial: 'select'}
      #aqui va la logica para consultar los historicos y estadisticos
      @historicos = Hst.gethst(@report)
      @stats = Hst.calcularestadisticos(@historicos)
      else
      format.html { render partial:'error' }

    end
  end
  end

  def getdatos

    if (params[:tstamp]) != 'NaN'
      @ts = params[:tstamp]
      @atr = params[:atr]
      @dat = Hst.tstamptiemporeal(@ts,@atr)
    else
      @dat = Hst.tstampultimo(@atr)
    end
    respond_to do |format|
      format.json { render json: @dat }
    end
  end

  end



