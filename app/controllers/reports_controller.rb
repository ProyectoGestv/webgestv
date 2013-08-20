class ReportsController < ApplicationController

  def index

     @reporte = Report.new
     @busquedarecurso=ManRsc.all
     @busquedamacroatributo = []
     @busquedaatributo =[]
     respond_to do |format|
     format.html
     format.json { render json: @reporte}
     end

   end


  def buscarmacroatr
    @reporte = Report.new
    @busquedamacroatributo=McrAtr.where(:tipo.all => ['composite'],:man_rsc_id => params[:manrsc])

    respond_to do |format|
      format.html { render partial: 'buscarmcr' , :link => @busquedamacroatributo}
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
        @busquedaatributo= Atr.where(:mcr_atr_id => @reporte.parasim)
        @busquedamacroatributo=McrAtr.where(:tipo.all => ['composite'] , :man_rsc_id => @reporte.manrsc)
        @busquedarecurso = ManRsc.all
        @atributo = @reporte.atrsim.to_s
        #aqui va la logica para consultar los historicos y estadisticos
        @historicos = Hst.consultarhistoricos(@reporte)
        @estadisticos = Hst.calcularestadisticos(@historicos)
        format.js { render :json => { :selectt => render_to_string(:partial => "reports/select") , :formm => render_to_string(:partial => "form") } }

      else
        @busquedaatributo= Atr.where(:mcr_atr_id => @reporte.parasim)
        @busquedamacroatributo=McrAtr.where(:tipo.all => ['composite'] , :man_rsc_id => @reporte.manrsc)
        @busquedarecurso = ManRsc.all
        format.html { render partial:'form' , :status => 500 }

      end
    end
  end

  def datostiemporeal
      @atributo = params[:atr]
      if (params[:tstamp]) != 'NaN'
      @tstamp = params[:tstamp]
      @datos = Hst.tstamptiemporeal(@tstamp,@atributo)
      if @datos == nil
      @datos = Hst.tstampultimohistorico(@atributo);
      end
      else
      @datos = Hst.tstampultimohistorico(@atributo)
      end
      respond_to do |format|
      format.json { render json: @datos}
      end
  end

  end



