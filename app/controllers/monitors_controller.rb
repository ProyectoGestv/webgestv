class MonitorsController < ApplicationController

def index

  @search_resource=ManRsc.all
  @search_mcr_atr = []
  @search_atr_variable = []
  @atr_simple = Atr.all
  @monitor = CompositeReportConfigurator.new
  fatrs=[]
  @atr_simple.each do |atr|
    frca=Filter.new
    frca.atributte=atr
    fatrs << frca
  end
  puts fatrs.as_json
  @monitor.form_report_composite_attrs=fatrs

  respond_to do |format|
    format.html
    format.json { render json: @monitor}
  end


end

def search_mcr_atr
  @monitor = CompositeReportConfigurator.new
  @mon_atr = Filter.new
  @search_mcr_atr=McrAtr.where(:tipo.all => ['composite'],:man_rsc_id => params[:manrsc])

respond_to do |format|
  format.html { render partial: 'search_mcr' , :link => @search_mcr_atr}
end
end


def search_atr_variable
  @monitor = CompositeReportConfigurator.new
  @mon_atr = Filter.new
  @search_atr_variable =  Atr.where(:mcr_atr_id => params[:paracom])
  respond_to do |format|
    format.html { render partial: 'search_atr_variable' , :link => @search_atr_variable}
  end
end


def updateresource
  @monitor = CompositeReportConfigurator.new
end


end
