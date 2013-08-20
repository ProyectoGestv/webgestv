class CompositesController < ApplicationController

  def index
    @atrsearch = []
    @atrsearchc = []
    @refreshatr = []
    @historicos = []
    @filter3 = []
    @busquedaatributo = []
    @reporte = Report.new
    @composite = Composite.new
    @mcrsearch=McrAtr.where(:tipo.all => ['composite'])
    respond_to do |format|
    format.html # new.html.erb
    format.json { render json: @composite }
    end
  end

  def show
    @historicos = Hst.where(:atr_id =>params[:Hst_ids])
  end

  def searchatr
    @composite = Composite.new
    @atrsearch= Atr.where(:mcr_atr_id => params[:mcr])
    @mcrsearch = McrAtr.find(params[:mcr])

     respond_to do |format|
     format.html { render partial: 'searchatr' , :link => @atrsearch}
    end
  end

  def items   #historicos
    @composite = Composite.new
    #@atrsearchc= Atr.all
    @atrsearchc= Atr.find(params[:atrhst])
    @mcrcapturado = McrAtr.find(params[:mcr])
    @refreshatr=Atr.where(:mcr_atr_id => @mcrcapturado.id).excludes(id: @atrsearchc)
    respond_to do |format|
      format.html { render partial: 'items' , :link => @refreshatr}
    end
  end

  def actualizar
    @composite = Composite.new(params[:composite])
    @filter1 = params[:inf_id]
    @filter2 = params[:sup_id]
    @filter3 = params[:Hst_ids]


    puts @filter1.as_json
    puts @filter2.as_json
    puts @filter3.as_json
    #if @composite.valid?
      respond_to do |format|
        format.html { render partial: 'edit_multiple' , :link => @filter3}
      end
   # else
    #  render "index"
    #end
  end

  def search
    @historicos = Hst.search params[:hst1]
  end

  def edit_multiple
    @historicos = Hst.where(:atr_id =>params[:Hst_ids])
  end

  def update_items

  end
end