class ReportsController < ApplicationController

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
     format.html { render partial: 'buscaratr' , :link => @atrsearch}
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

    @atr = params[:atr]
    if (params[:tstamp]) != 'NaN'
      @ts = params[:tstampp]
      @dat = Hst.tstamptiemporeal(@ts,@atr)
    else
      @dat = Hst.tstampultimo(@atr)
    end
    respond_to do |format|
      format.json { render json: @dat }
    end
  end

  end



