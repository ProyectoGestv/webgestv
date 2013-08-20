# -*- encoding : utf-8 -*-
class AtrsController < ApplicationController
  # GET /atrs
  # GET /atrs.json
  def index
    @atrs = Atr.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @atrs }
    end
  end

  # GET /atrs/1
  # GET /atrs/1.json
  def show
    @atr = Atr.find(params[:id])

    respond_to do |format|
      format.html # _edit_multiple.html.erb
      format.json { render json: @atr }
    end
  end

  def index_sim
    puts params
    #params[:mcr_atr_id]
    puts params['mcr_atr_id']
    puts '//////////////////////////////////////////////'
    @atrs = Atr.where({'mcr_atr_id' => Moped::BSON::ObjectId(params['mcr_atr_id'])})
    #.find_by(:type => 'simple')
    respond_to do |format|
      format.html # show_sim.html.erb
      format.json { render json: @atr }
    end
  end

  def index_com
    @atrs = Atr.all

    respond_to do |format|
      format.html # show_sim.html.erb
      format.json { render json: @atr }
    end
  end

  # GET /atrs/new
  # GET /atrs/new.json
  def new
    @atr = Atr.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @atr }
    end
  end

  # GET /atrs/1/edit
  def edit
    @atr = Atr.find(params[:id])
  end

  # POST /atrs
  # POST /atrs.json
  def create
    @atr = Atr.new(params[:atr])

    respond_to do |format|
      if @atr.save
        format.html { redirect_to @atr, notice: 'Atr was successfully created.' }
        format.json { render json: @atr, status: :created, location: @atr }
      else
        format.html { render action: "new" }
        format.json { render json: @atr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /atrs/1
  # PUT /atrs/1.json
  def update
    @atr = Atr.find(params[:id])
    puts params
    puts '/////////////////////////////////////////////////////'
    respond_to do |format|
      if @atr.update_attributes(params[:atr])
        format.html { redirect_to :back }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @atr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /atrs/1
  # DELETE /atrs/1.json
  def destroy
    @atr = Atr.find(params[:id])
    @atr.destroy

    respond_to do |format|
      format.html { redirect_to atrs_url }
      format.json { head :no_content }
    end
  end
end
