class ReportsController < ApplicationController
  

  def index
  
  @opcion = params[:opcion]
  if @opcion == "Rango tiempo"
   @tiempo = params[:tiempo]
   @historicos=Hst.consultahistoricos(@tiempo)
  else 
   #@fechaa
   #@fechab 
   #@historicos = Hst.consultahistoricosfecha(@fechaa,@fechab)
    @historicos = Hst.all
  end   

  end


end



  #@historicos = Hst.all
  #@parser = Chronic.parse(@dia)
  #@integro = @parser.to_i
  #@historicos=Hst.all.or(:tstamp.lte => @integro)