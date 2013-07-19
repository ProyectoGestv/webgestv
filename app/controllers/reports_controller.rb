class ReportsController < ApplicationController

  def index
  @atrsearch = []
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
      @atrr = @report.atrsim.to_s
      #aqui va la logica para consultar los historicos y estadisticos
      @historicos = Hst.gethst(@report)
      @stats = Hst.calcularestadisticos(@historicos)
      format.html { render partial: 'select'}
     else
       @atrsearch= Atr.where(:mcr_atr_id => @report.parasim)
       @mcrsearch=McrAtr.where(:tipo.all => ['simple'])
      format.html { render partial:'form' , :status => 500 }

    end
  end
  end

  def getdatos

    #@atr = (params[:atr])

    @tr = params[:atr]

    if (params[:tstamp]) != 'NaN'
      @ts = params[:tstamp]
      @dat = Hst.tstamptiemporeal(@ts,@tr)
    else
      @dat = Hst.tstampultimo(@tr)
    end
    respond_to do |format|
      format.json { render json: @dat }
    end
  end

  end



