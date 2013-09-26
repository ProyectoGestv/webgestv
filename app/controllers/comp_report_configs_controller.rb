class CompReportConfigsController < ApplicationController

def index
  #busqueda de atributos recibe un param pero inicialmente lo busco directamente en bd
  @search_mcr_atr=McrAtr.where(:tipo.all => ['composite'], :id=> '52445293d1b39c7327000001')
  @search_attributes =  Atr.where(:mcr_atr_id => @search_mcr_atr.first())
  ####################################################################################
  @report_configurator = Reports::Composite::Configurator.new
  filters = []
  @search_attributes.each do |atr|
    filter=  Reports::Composite::Filter.new
    filter.associated_attribute  = atr
    filters << filter
  end
  @report_configurator.filters = filters
  respond_to do |format|
    format.html
  end
end


def search_information

end


end
