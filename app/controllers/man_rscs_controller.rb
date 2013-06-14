# -*- encoding : utf-8 -*-
require 'net/http'

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

  def mngable
    @man_rsc = ManRsc.find(params[:man_rsc_id])
    act=params[:act]
    @man_rsc.mngbl=act
    @man_rsc.save

    http = Net::HTTP.new("192.168.119.35",9999)
    if act == 'true'
      post_params = {'ip' => @man_rsc.conn.ip, 'port' => @man_rsc.conn.port, 'domain' => @man_rsc.domain, 'type' => @man_rsc.name}
      #post_params = "ip=#{@man_rsc.conn.ip}, port=#{@man_rsc.conn.port}, domain=#{@man_rsc.domain}, type=#{@man_rsc.name}"
      #resp = Net::HTTP.post_form URI('http://192.168.119.35:9999/mbs/register'), post_params
      request = Net::HTTP::Post.new("/mbs/register")
      request.set_form_data(post_params)
      response = http.request(request)
    else
      post_params = {'ip' => @man_rsc.conn.ip, 'port' => @man_rsc.conn.port}
      request = Net::HTTP::Delete.new("/mbs/#{@man_rsc.domain}/#{@man_rsc.name}")
      request.set_form_data(post_params)
      response = http.request(request)
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def alrtable
    @man_rsc = ManRsc.find(params[:man_rsc_id])
    act=params[:act]
    @man_rsc.alrtbl=act
    @man_rsc.save

    http = Net::HTTP.new("192.168.119.35",9999)
    if act == 'true'
      request = Net::HTTP::Put.new("/mbs/#{@man_rsc.domain}/#{@man_rsc.name}/alerts/act")
      response = http.request(request)
    else
      request = Net::HTTP::Put.new("/mbs/#{@man_rsc.domain}/#{@man_rsc.name}/alerts/inact")
      response = http.request(request)
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def create

  end

  def update

  end

  def destroy

  end

end
