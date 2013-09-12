class MonitorsController < ApplicationController

def index
  @monitor = Monitor_composite.new
  @mon_atr = Monitor_atr_composite.new
  @search_resource=ManRsc.all
  @search_mcr_atr = []
  @search_atr_variable = []

  respond_to do |format|
    format.html
    format.json { render json: @monitor}
  end


end

def search_mcr_atr
  @monitor = Monitor_composite.new
  @mon_atr = Monitor_atr_composite.new
  @search_mcr_atr=McrAtr.where(:tipo.all => ['composite'],:man_rsc_id => params[:manrsc])
  respond_to do |format|
    format.html { render partial: 'search_mcr' , :link => @search_mcr_atr}
  end
end


def search_atr_variable
  @monitor = Monitor_composite.new
  @mon_atr = Monitor_atr_composite.new
  @search_atr_variable =  Atr.where(:mcr_atr_id => params[:paracom])
  respond_to do |format|
    format.html { render partial: 'search_atr_variable' , :link => @search_atr_variable}
  end
end


def updateresource
   @monitor = Monitor_composite.new
end


end
