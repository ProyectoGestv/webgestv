class CompReportConfigsController < ApplicationController

def index
  #busqueda de atributos recibe un param pero inicialmente lo busco directamente en bd
  @search_mcr_atr = McrAtr.all.first
  #@search_mcr_atr = McrAtr.find_by(id: '5267f4c0d1b39c6a80000001')
  @search_attributes =  Atr.where(:mcr_atr_id => @search_mcr_atr)
  ####################################################################################
  @report_configurator = Reports::Composite::Configurator.new
  filters = []
  @search_attributes.each do |atr|
    filter=  Reports::Composite::Filter.new
    filter.name_attribute  = atr.name
    filter.tipo_attribute = atr.tipo
    filter.associated_attribute = atr.id
    filters << filter
  end
  @report_configurator.filters = filters
  respond_to do |format|
    format.html
    format.json { render json: @report_configurator }
  end

end

def search_information

  @search_mcr_atr = McrAtr.all.first
  @search_attributes =  Atr.where(:mcr_atr_id => @search_mcr_atr)
  ####################################################################################
  @report_configurator = Reports::Composite::Configurator.new
  filters = []
  @search_attributes.each do |atr|
    filter=  Reports::Composite::Filter.new
    filter.name_attribute  = atr.name
    filter.tipo_attribute = atr.tipo
    filter.associated_attribute = atr.id
    filters << filter
  end
  @report_configurator.filters = filters

  @report_configurator_params = Reports::Composite::Configurator.new(params[:reports_composite_configurator])

  @report_configurator= Reports::Composite::Configurator.update_attributes(@report_configurator , @report_configurator_params)

  puts 'actualizados'
  puts  @report_configurator.as_json

  respond_to do |format|
  if @report_configurator.valid?
   @hst_filtered = Reports::Composite::Configurator.find_values_filters(@report_configurator.filters , @report_configurator.variable_atr);
   format.js { render :json => { :selectt => render_to_string(:partial => "comp_report_configs/grafico") , :formm => render_to_string(:partial => "form")}}
  else
   format.html {render partial:'form' , :status => 500}
  end
  end
end

end



#binding.pry
# puts '--> Report Configurator: ', @report_configurator.filters.as_json
