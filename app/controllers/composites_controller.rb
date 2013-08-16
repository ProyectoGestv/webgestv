class CompositesController < ApplicationController

  def index
    @atrsearch = []
    @atrsearchc = []
    @refreshatr = []
    @composite = Composite.new
    @mcrsearch=McrAtr.where(:tipo.all => ['composite'])
    respond_to do |format|
    format.html # new.html.erb
    format.json { render json: @composite }
    end
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
    if @composite.valid?
      # TODO send message here

      redirect_to root_url, notice: "Mensaje enviado. Gracias por contactarnos"
    else
      render "index"
    end
  end
end