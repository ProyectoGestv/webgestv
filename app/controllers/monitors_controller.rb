class MonitorsController < ApplicationController

def index
  @monitor = FormReportsComposite.new
  @search_resource=ManRsc.all
  @search_mcr_atr = []
  @search_atr_variable = []
  @atr_simple = Atr.all

  fatrs=[]
  @atr_simple.each do |atr|
    frca=FormReportAtrComposite.new
    frca.atr = atr
    fatrs << frca
  end
  @monitor.form_report_composite_attrs=fatrs

  respond_to do |format|
    format.html
    format.json { render json: @monitor}
  end


end

def search_mcr_atr
  @monitor = FormReportsComposite.new
  @mon_atr = FormReportAtrComposite.new
  @search_mcr_atr=McrAtr.where(:tipo.all => ['composite'],:man_rsc_id => params[:manrsc])

respond_to do |format|
  format.html { render partial: 'search_mcr' , :link => @search_mcr_atr}
end
end


def search_atr_variable
  @monitor = FormReportsComposite.new
  @mon_atr = FormReportAtrComposite.new
  @search_atr_variable =  Atr.where(:mcr_atr_id => params[:paracom])
  respond_to do |format|
    format.html { render partial: 'search_atr_variable' , :link => @search_atr_variable}
  end
end


def updateresource
  @monitor = FormReportsComposite.new
end


end
