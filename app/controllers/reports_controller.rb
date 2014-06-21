class ReportsController < ApplicationController

  def index

      @reporte = Report.new
      @busquedarecurso=ManRsc.all

      if (params[:mcr_atr]).present? ||  (params[:atr]).present?

       @macro_preselected = McrAtr.find_by(:id => params[:mcr_atr])
       @recurso_preselected = ManRsc.find_by(:id => @macro_preselected.man_rsc_id)
       @busquedamacroatributo = McrAtr.where(:tipo.all => ['simple'],:man_rsc_id => @recurso_preselected.id)
       @atr_preselected= Atr.find_by(:id => params[:atr])
       @busquedaatributo = Atr.where(:mcr_atr_id => @macro_preselected.id)
      else
        @recurso_preselected = @busquedarecurso.first
        @busquedamacroatributo = McrAtr.where(:tipo.all => ['simple'],:man_rsc_id => @recurso_preselected.id)
        @macro_preselected = @busquedamacroatributo.first
        @busquedaatributo= Atr.where(:mcr_atr_id => @macro_preselected.id)
        @atr_preselected = @busquedaatributo.first
      end
     respond_to do |format|
     format.html
     format.json { render json: @reporte}
     end

   end


  def buscarmacroatr
    @reporte = Report.new
    @busquedamacroatributo=McrAtr.where(:tipo.all => ['simple'],:man_rsc_id => params[:manrsc])
    @macro_preselected = @busquedamacroatributo.first
    respond_to do |format|
       format.html { render partial: 'buscarmcr' , :link => @busquedamacroatributo}
    end
  end



  def buscaratributo
    @reporte = Report.new
    @busquedaatributo= Atr.where(:mcr_atr_id => params[:mcr])
    @atr_preselected = @busquedaatributo.first
    respond_to do |format|
    format.html { render partial: 'buscaratr' , :link => @busquedaatributo}
    end
  end


  def actualizartabla

   @reporte= Report.new(params[:report])

   respond_to do |format|
   if @reporte.valid?
      @busquedaatributo= Atr.where(:mcr_atr_id => @reporte.parasim)
      @busquedamacroatributo=McrAtr.where(:tipo.all => ['simple'] , :man_rsc_id => @reporte.manrsc)
      @busquedarecurso = ManRsc.all
      @atributo = @reporte.atrsim.to_s
      @macro_preselected = McrAtr.find_by(:id => @reporte.parasim)
      @recurso_preselected = ManRsc.find_by(:id => @reporte.manrsc)
      @atr_preselected = Atr.find_by(:id => @reporte.atrsim)
      #aqui va la logica para consultar los historicos y estadisticos
      @historicos = AtrHst.consultarhistoricos(@reporte)
      @estadisticos = AtrHst.calcularestadisticos(@historicos)
      format.js { render :json => { :selectt => render_to_string(:partial => "reports/select") , :formm => render_to_string(:partial => "form") } }

   else
     @busquedaatributo= Atr.where(:mcr_atr_id => @reporte.parasim)
     @busquedamacroatributo=McrAtr.where(:tipo.all => ['simple'] , :man_rsc_id => @reporte.manrsc)
     @busquedarecurso = ManRsc.all
     format.html { render partial:'form' , :status => 500 }

  end
  end
  end

  def datostiemporeal
      @atributo = params[:atr]
      if (params[:tstamp]) != 'NaN'
      @tstamp = params[:tstamp]
      @datos = AtrHst.tstamptiemporeal(@tstamp,@atributo)
      if @datos == nil
      @datos = AtrHst.tstampultimohistorico(@atributo);
      end
      else
      @datos = AtrHst.tstampultimohistorico(@atributo)
      end
      respond_to do |format|
      format.json { render json: @datos}
      end
  end

  end



