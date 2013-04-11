# -*- encoding : utf-8 -*-
class AlrMntrFrmlsController < ApplicationController
  # GET /alr_mntr_frmls
  # GET /alr_mntr_frmls.json
  def index
    @alr_mntr_frmls = AlrMntrFrml.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alr_mntr_frmls }
    end
  end

  # GET /alr_mntr_frmls/1
  # GET /alr_mntr_frmls/1.json
  def show
    @alr_mntr_frml = AlrMntrFrml.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alr_mntr_frml }
    end
  end

  # GET /alr_mntr_frmls/new
  # GET /alr_mntr_frmls/new.json
  def new
    session[:return_to]=request.referer
    session[:mcr_atr_id]=params[:mcr_atr_id]
    @alr_mntr_frml = AlrMntrFrml.new
    @url=man_rsc_mcr_atr_alr_mntr_frmls_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alr_mntr_frml }
    end
  end

  # GET /alr_mntr_frmls/1/edit
  def edit
    session[:return_to]=request.referer
    session[:mcr_atr_id]=params[:mcr_atr_id]
    @alr_mntr_frml = McrAtr.find(params[:mcr_atr_id]).alr_mon
    @url=man_rsc_mcr_atr_alr_mntr_frml_path(@alr_mntr_frml.id)
  end

  # POST /alr_mntr_frmls
  # POST /alr_mntr_frmls.json
  def create
    @alr_mntr_frml = AlrMntrFrml.new(params[:alr_mntr_frml])
    mcr_atr=McrAtr.find(session[:mcr_atr_id])
    mcr_atr.alr_mon=@alr_mntr_frml
    @alr_mntr_frml.mcr_atr=mcr_atr

    respond_to do |format|
      if @alr_mntr_frml.save
        format.html { redirect_to session[:return_to], notice: t('alarms.create.notice') }
        format.json { render json: @alr_mntr_frml, status: :created, location: @alr_mntr_frml }
      else
        @url=man_rsc_mcr_atr_alr_mntr_frmls_path
        format.html { render action: "new" }
        format.json { render json: @alr_mntr_frml.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /alr_mntr_frmls/1
  # PUT /alr_mntr_frmls/1.json
  def update
    @alr_mntr_frml = McrAtr.find(session[:mcr_atr_id]).alr_mon

    respond_to do |format|
      if @alr_mntr_frml.update_attributes(params[:alr_mntr_frml])
        format.html { redirect_to session[:return_to], notice: t('alarms.update.notice') }
        format.json { head :no_content }
      else
        @url=man_rsc_mcr_atr_alr_mntr_frml_path(@alr_mntr_frml.id)
        format.html { render action: "edit" }
        format.json { render json: @alr_mntr_frml.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alr_mntr_frmls/1
  # DELETE /alr_mntr_frmls/1.json
  def destroy
    @alr_mntr_frml = McrAtr.find(params[:mcr_atr_id]).alr_mon
    @alr_mntr_frml.destroy

    respond_to do |format|
      format.html { redirect_to :back, notice: t('forms.delalarms.notice') }
      format.json { head :no_content }
    end
  end

  def state
    puts '//////////////////////////////////////////////////////'
    @alr_mntr_frml = McrAtr.find(params[:mcr_atr_id]).alr_mon
    if @alr_mntr_frml.state == 'act'
      @alr_mntr_frml.state='inact'
    else
      @alr_mntr_frml.state='act'
    end
    @alr_mntr_frml.save
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

end
