# -*- encoding : utf-8 -*-
class AlrMntrCntrsController < ApplicationController
  # GET /alr_mntr_cntrs
  # GET /alr_mntr_cntrs.json
  def index
    @alr_mntr_cntrs = AlrMntrCntr.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alr_mntr_cntrs }
    end
  end

  # GET /alr_mntr_cntrs/1
  # GET /alr_mntr_cntrs/1.json
  def show
    @alr_mntr_cntr = AlrMntrCntr.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alr_mntr_cntr }
    end
  end

  # GET /alr_mntr_cntrs/new
  # GET /alr_mntr_cntrs/new.json
  def new
    session[:return_to]=request.referer
    session[:atr_id]=params[:atr_id]
    session[:alr_cat]=params[:alr_cat]
    @alr_mntr_cntr = AlrMntrCntr.new
    @url=man_rsc_mcr_atr_atr_alr_mntr_cntrs_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alr_mntr_cntr }
    end
  end

  # GET /alr_mntr_cntrs/1/edit
  def edit
    session[:return_to]=request.referer
    session[:atr_id]=params[:atr_id]
    session[:alr_cat]=params[:alr_cat]

    if params[:alr_cat]=='qos'
      @alr_mntr_cntr = Atr.find(params[:atr_id]).qos_mon
    else
      @alr_mntr_cntr = Atr.find(params[:atr_id]).alr_mon
    end
    @url=man_rsc_mcr_atr_atr_alr_mntr_cntr_path(@alr_mntr_cntr.id)
  end

  # POST /alr_mntr_cntrs
  # POST /alr_mntr_cntrs.json
  def create
    @alr_mntr_cntr = AlrMntrCntr.new(params[:alr_mntr_cntr])
    atr=Atr.find(session[:atr_id])
    if session[:alr_cat]=='qos'
      atr.qos_mon=@alr_mntr_cntr
    else
      atr.alr_mon=@alr_mntr_cntr
    end
    @alr_mntr_cntr.atr=atr

    respond_to do |format|
      if @alr_mntr_cntr.save
        format.html { redirect_to session[:return_to], notice: 'Alr mntr cntr was successfully created.' }
        format.json { render json: @alr_mntr_cntr, status: :created, location: @alr_mntr_cntr }
      else
        @url=man_rsc_mcr_atr_atr_alr_mntr_cntrs_path
        format.html { render action: "new" }
        format.json { render json: @alr_mntr_cntr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /alr_mntr_cntrs/1
  # PUT /alr_mntr_cntrs/1.json
  def update
    if session[:alr_cat]=='qos'
      @alr_mntr_cntr = Atr.find(session[:atr_id]).qos_mon
    else
      @alr_mntr_cntr = Atr.find(session[:atr_id]).alr_mon
    end

    respond_to do |format|
      if @alr_mntr_cntr.update_attributes(params[:alr_mntr_cntr])
        format.html { redirect_to session[:return_to], notice: 'Alr mntr cntr was successfully updated.' }
        format.json { head :no_content }
      else
        @url=man_rsc_mcr_atr_atr_alr_mntr_cntr_path(@alr_mntr_cntr.id)
        format.html { render action: "edit" }
        format.json { render json: @alr_mntr_cntr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alr_mntr_cntrs/1
  # DELETE /alr_mntr_cntrs/1.json
  def destroy
    @alr_mntr_cntr = nil
    if params[:alr_cat]=='qos'
      @alr_mntr_cntr = Atr.find(params[:atr_id]).qos_mon
    else
      @alr_mntr_cntr = Atr.find(params[:atr_id]).alr_mon
    end
    @alr_mntr_cntr.destroy

    respond_to do |format|
      format.html { redirect_to :back, notice: 'Alr mntr cntr was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
