class ReportsController < ApplicationController

  def index

     @reporte = Report.new
     @busquedamacroatributo=McrAtr.where(:tipo.all => ['simple'])
     @busquedaatributo = []
     respond_to do |format|
     format.html
     format.json { render json: @reporte}
     end

   end


  def buscaratributo
    @reporte = Report.new
    @busquedaatributo= Atr.where(:mcr_atr_id => params[:mcr])
    respond_to do |format|
    format.html { render partial: 'buscaratr' , :link => @busquedaatributo}
    end
  end


  def actualizartabla

   @reporte= Report.new(params[:report])
   respond_to do |format|
   if @reporte.valid?
      @atributo = @reporte.atrsim.to_s
      #aqui va la logica para consultar los historicos y estadisticos
      @historicos = Hst.consultarhistoricos(@reporte)
      @estadisticos = Hst.calcularestadisticos(@historicos)
      format.html { render partial: 'select'}
     else
       @busquedaatributo= Atr.where(:mcr_atr_id => @reporte.parasim)
       @busquedamacroatributo=McrAtr.where(:tipo.all => ['simple'])
       format.html { render partial:'form' , :status => 500 }

  end
  end
  end

  def datostiemporeal

      @atributo = params[:atr]
      if (params[:tstamp]) != 'NaN'
      @tstamp = params[:tstamp]
      @datos = Hst.tstamptiemporeal(@tstamp,@atributo)
      else
      @datos = Hst.tstampultimohistorico(@atributo)
      end
      respond_to do |format|
      format.json { render json: @datos}
      end
  end

  end



