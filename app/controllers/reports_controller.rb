class ReportsController < ApplicationController
  

  def index
  @opcion = params[:opcion]
  @atr = params[:atr]
  if @opcion == "Rango tiempo"
   @tiempo = params[:tiempo]
   @historicos=Hst.consultahistoricos(@tiempo,@atr)
  else 
   @fechaa = params[:fechaa]
   @fechab = params[:fechab]
   @historicos = Hst.consultahistoricosfecha(@fechaa,@fechab,@atr)
   
  end   
   @stats = Hst.calcularestadisticos(@historicos)
  end
  end



  #@historicos = Hst.all
  #@parser = Chronic.parse(@dia)
  #@integro = @parser.to_i
  #@historicos=Hst.all.or(:tstamp.lte => @integro)

  #