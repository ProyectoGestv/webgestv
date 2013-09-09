# -*- encoding : utf-8 -*-
class LaynetElesController < ApplicationController
  # GET /laynet_eles
  # GET /laynet_eles.json
  def index
    @laynet_eles = LaynetEle.all

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @laynet_eles }
    end
  end

  # GET /laynet_eles/1
  # GET /laynet_eles/1.json
  def show
    @laynet_ele = LaynetEle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @laynet_ele }
    end
  end

  # GET /laynet_eles/new
  # GET /laynet_eles/new.json
  def new
    @laynet_ele = LaynetEle.new
    @conn=Conn.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @laynet_ele }
    end
  end

  # GET /laynet_eles/1/edit
  def edit
    @laynet_ele = LaynetEle.find(params[:id])
    @conn = @laynet_ele.conn
  end

  # POST /laynet_eles
  # POST /laynet_eles.json
  def create
    params[:laynet_ele][:domain]='SNMPIntegrationServer'
    @laynet_ele = LaynetEle.new(params[:laynet_ele])
    @conn=Conn.new(params[:laynet_ele][:conn])
    @laynet_ele.conn=@conn
    respond_to do |format|
      if @laynet_ele.save
        format.html { redirect_to laynet_eles_url, notice: t('laynet_eles.create.notice') }
        format.json { render json: @laynet_ele, status: :created, location: @laynet_ele }
      else
        format.html { render action: "new" }
        format.json { render json: @laynet_ele.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /laynet_eles/1
  # PUT /laynet_eles/1.json
  def update
    @laynet_ele = LaynetEle.find(params[:id])
    @conn = @laynet_ele.conn
    pass1=@conn.update_attributes(params[:laynet_ele][:conn])
    pass2=@laynet_ele.update_attributes(params[:laynet_ele])
    respond_to do |format|
      if pass1 and pass2
        format.html { redirect_to laynet_eles_url, notice: t('laynet_eles.update.notice') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @laynet_ele.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /laynet_eles/1
  # DELETE /laynet_eles/1.json
  def destroy
    @laynet_ele = LaynetEle.find(params[:id])
    @laynet_ele.destroy

    respond_to do |format|
      format.html { redirect_to laynet_eles_url, notice: t('laynet_eles.delete.notice') }
      format.json { head :no_content }
    end
  end

  def testconn
    @m='No hay conexión'
    @cs='error'
    ip=params['ip']
    port=params['port']
    if self.is_port_open?(ip,port)
      @m='Conexión exitosa'
      @cs='success'
    end
    respond_to do |format|
      format.js {}
    end
  end

  def is_port_open?(ip, port)
    begin
      Timeout::timeout(1) do
        begin
          s = TCPSocket.new(ip, port)
          s.close
          return true
        rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH, Errno::EADDRNOTAVAIL, SocketError
          return false
        end
      end
    rescue Timeout::Error
    end
    return false
  end

end
