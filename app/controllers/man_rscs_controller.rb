# -*- encoding : utf-8 -*-
class ManRscsController < ApplicationController
  #, "mcr_atrs/#{mcr_atr._id}/atrs/#{atr._id}/alr_mntr_cntrs/new?alr_cat=qos"
  def index
    @man_rscs = ManRsc.all.order_by(:name.asc)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @man_rscs }
    end
  end


  def show
    @man_rsc = ManRsc.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @man_rsc }
    end
  end


  def new
    @man_rsc = ManRsc.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @man_rsc }
    end
  end

  def edit
    @man_rsc = ManRsc.find(params[:id])

  end

  def create

  end

  def update

  end

  def destroy

  end

end