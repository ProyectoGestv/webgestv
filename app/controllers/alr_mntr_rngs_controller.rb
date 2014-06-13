# -*- encoding : utf-8 -*-
require 'net/http'
class AlrMntrRngsController < ApplicationController
  # GET /alr_mntr_rngs
  # GET /alr_mntr_rngs.json
  def index
    @alr_mntr_rngs = AlrMntrRng.all

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @alr_mntr_rngs }
    end
  end

  # GET /alr_mntr_rngs/1
  # GET /alr_mntr_rngs/1.json
  def show
    @alr_mntr_rng = AlrMntrRng.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alr_mntr_rng }
    end
  end

  # GET /alr_mntr_rngs/new
  # GET /alr_mntr_rngs/new.json
  def new
    session[:return_to]=request.referer
    session[:atr_id]=params[:atr_id]
    session[:alr_cat]=params[:alr_cat]
    @alr_mntr_rng = AlrMntrRng.new
    @url=man_rsc_mcr_atr_atr_alr_mntr_rngs_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alr_mntr_rng }
    end
  end

  # GET /alr_mntr_rngs/1/edit
  def edit
    session[:return_to]=request.referer
    session[:atr_id]=params[:atr_id]
    session[:alr_cat]=params[:alr_cat]

    if params[:alr_cat]=='qos'
      @alr_mntr_rng = Atr.find(params[:atr_id]).qos_mon
    else
      @alr_mntr_rng = Atr.find(params[:atr_id]).alr_mon
    end
    @url=man_rsc_mcr_atr_atr_alr_mntr_rng_path(@alr_mntr_rng.id)
  end

  # POST /alr_mntr_rngs
  # POST /alr_mntr_rngs.json
  def create
    @alr_mntr_rng = AlrMntrRng.new(params[:alr_mntr_rng])
    atr=Atr.find(session[:atr_id])
    if session[:alr_cat]=='qos'
      atr.qos_mon=@alr_mntr_rng
    else
      atr.alr_mon=@alr_mntr_rng
    end
    @alr_mntr_rng.atr=atr

    respond_to do |format|
      if @alr_mntr_rng.save
        message_state(atr.mcr_atr.man_rsc, atr.mcr_atr, atr, session[:alr_cat], 'on')
        format.html { redirect_to session[:return_to], notice: t('alarms.create.notice') }
        format.json { render json: @alr_mntr_rng, status: :created, location: @alr_mntr_rng }
      else
        @url=man_rsc_mcr_atr_atr_alr_mntr_rngs_path
        format.html { render action: "new" }
        format.json { render json: @alr_mntr_rng.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /alr_mntr_rngs/1
  # PUT /alr_mntr_rngs/1.json
  def update
    atr=Atr.find(session[:atr_id])
    if session[:alr_cat]=='qos'
      @alr_mntr_rng = atr.qos_mon
    else
      @alr_mntr_rng = atr.alr_mon
    end

    respond_to do |format|
      if @alr_mntr_rng.update_attributes(params[:alr_mntr_rng])
        message_state(atr.mcr_atr.man_rsc, atr.mcr_atr, atr, session[:alr_cat], 'off')
        message_state(atr.mcr_atr.man_rsc, atr.mcr_atr, atr, session[:alr_cat], 'on')
        format.html { redirect_to session[:return_to], notice: t('alarms.update.notice') }
        format.json { head :no_content }
      else
        @url=man_rsc_mcr_atr_atr_alr_mntr_rng_path(@alr_mntr_rng.id)
        format.html { render action: "edit" }
        format.json { render json: @alr_mntr_rng.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alr_mntr_rngs/1
  # DELETE /alr_mntr_rngs/1.json
  def destroy
    @alr_mntr_rng = nil
    atr=Atr.find(params[:atr_id])
    if params[:alr_cat]=='qos'
      @alr_mntr_rng = atr.qos_mon
    else
      @alr_mntr_rng = atr.alr_mon
    end
    @alr_mntr_rng.destroy
    message_state(atr.mcr_atr.man_rsc, atr.mcr_atr, atr, params[:alr_cat], 'off')
    respond_to do |format|
      format.html { redirect_to :back, notice: t('forms.delalarms.notice') }
      format.json { head :no_content }
    end
  end

  def state
    @alr_mntr_rng = nil
    atr=Atr.find(params[:atr_id])
    if params[:alr_cat]=='qos'
      @alr_mntr_rng = atr.qos_mon
    else
      @alr_mntr_rng = atr.alr_mon
    end
    ma=atr.mcr_atr
    mr=ma.man_rsc
    if @alr_mntr_rng.state == 'act'
      @alr_mntr_rng.state='inact'
      message_state(mr, ma, atr, params[:alr_cat], 'off')
    else
      @alr_mntr_rng.state='act'
      message_state(mr, ma, atr, params[:alr_cat], 'on')
    end
    @alr_mntr_rng.save
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private

  def message_state(mr, ma, atr, alr_cat, state)
    if mr.mngbl && mr.alrtbl
      http = Net::HTTP.new("192.168.119.163",9999)
      request = Net::HTTP::Put.new("/mbs/#{mr.domain}/#{mr.name}/#{ma.name}/#{atr._id}/#{alr_cat}/#{state}")
      begin
        http.request(request)
      rescue Errno::ECONNREFUSED
      end
    end
  end

end
