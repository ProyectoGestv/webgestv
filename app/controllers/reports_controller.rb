class ReportsController < ApplicationController
  

  def index
  @dia = params[:dia]
  @consulta = params[:destination]
  @parametro = ["paris","londres","madrid"]
  #@historicos = Hst.all
  #@parser = Chronic.parse(@dia)
  #@integro = @parser.to_i
  #@historicos=Hst.all.or(:tstamp.lte => @integro)
  @historicos=Hst.consultahistoricos(@dia)
  end


end
