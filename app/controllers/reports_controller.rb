class ReportsController < ApplicationController
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

  def getdatos

    if (params[:tstamp]) != 'NaN'
       @ts = params[:tstamp]
       @dat = Hst.tstamptiemporeal(@ts,$atrr)
      #@dat = Dat.find_by_tstamp(params[:tstamp])
      #@datt = Hst.where("tstamp > #{params[:tstamp]}")
    else
       @dat = Hst.tstampultimo($atrr)
    end
      respond_to do |format|
      format.json { render json: @dat }
    end
  end
  end


