class MonitorsController < ApplicationController

def index
  @monit = Monitor_composite.new
  @search_resource=ManRsc.all
  @search_mcr_atr = []

  respond_to do |format|
    format.html
    format.json { render json: @monitor}
  end


end


def search_mcr_atr
  @monit = Monitor_composite.new
  @search_mcr_atr=McrAtr.where(:tipo.all => ['composite'],:man_rsc_id => params[:manrsc])
  respond_to do |format|
    format.html { render partial: 'search_mcr' , :link => @search_mcr_atr}
  end
end


def updateresource
   @monit = Monitor_composite.new
end


end
