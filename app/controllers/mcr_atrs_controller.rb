# -*- encoding : utf-8 -*-
class McrAtrsController < ApplicationController
  # GET /mcr_atrs
  # GET /mcr_atrs.json
  def index
    @mcr_atrs = McrAtr.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mcr_atrs }
    end
  end

  # GET /mcr_atrs/1
  # GET /mcr_atrs/1.json
  def show
    @mcr_atr = McrAtr.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mcr_atr }
    end
  end

  # GET /mcr_atrs/new
  # GET /mcr_atrs/new.json
  def new
    @mcr_atr = McrAtr.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mcr_atr }
    end
  end

  # GET /mcr_atrs/1/edit
  def edit
    @mcr_atr = McrAtr.find(params[:id])
  end

  # POST /mcr_atrs
  # POST /mcr_atrs.json
  def create
    @mcr_atr = McrAtr.new(params[:mcr_atr])

    respond_to do |format|
      if @mcr_atr.save
        format.html { redirect_to @mcr_atr, notice: 'Mcr atr was successfully created.' }
        format.json { render json: @mcr_atr, status: :created, location: @mcr_atr }
      else
        format.html { render action: "new" }
        format.json { render json: @mcr_atr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mcr_atrs/1
  # PUT /mcr_atrs/1.json
  def update
    @mcr_atr = McrAtr.find(params[:id])

    respond_to do |format|
      if @mcr_atr.update_attributes(params[:mcr_atr])
        format.html { redirect_to @mcr_atr, notice: 'Mcr atr was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mcr_atr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mcr_atrs/1
  # DELETE /mcr_atrs/1.json
  def destroy
    @mcr_atr = McrAtr.find(params[:id])
    @mcr_atr.destroy

    respond_to do |format|
      format.html { redirect_to mcr_atrs_url }
      format.json { head :no_content }
    end
  end
end
