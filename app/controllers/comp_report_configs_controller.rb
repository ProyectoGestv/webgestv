class CompReportConfigsController < ApplicationController

def index
  #busqueda de atributos recibe un param pero inicialmente lo busco directamente en bd
  @search_mcr_atr = McrAtr.all.first
  @search_attributes =  Atr.where(:mcr_atr_id => @search_mcr_atr)
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
    format.json { render json: @report_configurator }
  end

end

def search_information
  @report_configurator = Reports::Composite::Configurator.new(params[:reports_composite_configurator])
  respond_to do |format|
  if @report_configurator.valid?
   @variable_atr = Reports::Composite::Configurator.find_values_variable_atr(@report_configurator.variable_atr);
   @values_filters = Reports::Composite::Configurator.find_values_filters(@report_configurator.filters);

    format.html { render partial:'grafico'}






   else
     #busqueda de atributos recibe un param pero inicialmente lo busco directamente en bd
     @search_mcr_atr = McrAtr.all.first
     @search_attributes =  Atr.where(:mcr_atr_id => @search_mcr_atr)
     ####################################################################################
     @report_configurator = Reports::Composite::Configurator.new
     filters = []
     @search_attributes.each do |atr|
       filter=  Reports::Composite::Filter.new
       filter.associated_attribute  = atr
       filters << filter
     end
     @report_configurator.filters = filters

    format.html {render partial:'form' , :status => 500}
   end
  end
end

end



#binding.pry
# puts '--> Report Configurator: ', @report_configurator.filters.as_json
