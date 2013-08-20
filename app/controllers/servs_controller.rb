# -*- encoding : utf-8 -*-
class ServsController < ApplicationController
  # GET /servs
  # GET /servs.json
  def index
    @servs = Serv.all.order_by(:name.asc)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @servs }
    end
  end

  # GET /servs/1
  # GET /servs/1.json
  def show
    @serv = Serv.find(params[:id])

    respond_to do |format|
      format.html # _edit_multiple.html.erb
      format.json { render json: @serv }
    end
  end

  # GET /servs/new
  # GET /servs/new.json
  def new
    @serv = Serv.new
    @conn=Conn.new
    @net_eles = NetEle.all
    if @net_eles.count > 0
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @serv }
      end
    else
      respond_to do |format|
        format.html { redirect_to servs_url, notice: t('servs.delete.error_mo')  }
        format.json { render json: @servs.errors, status: :unprocessable_entity }
      end
    end

  end

  # GET /servs/1/edit
  def edit
    @serv = Serv.find(params[:id])
    @net_eles = NetEle.all
    @conn = @serv.conn
  end

  # POST /servs
  # POST /servs.json
  def create
    #params[:serv][:domain]=params[:serv][:name]
    @serv = Serv.new(params[:serv])
    if @serv.mother
      @serv.domain=@serv.mother.name
      params[:serv][:conn][:ip]=@serv.mother.conn.ip
      puts params
    end
    @conn=Conn.new(params[:serv][:conn])
    @serv.conn=@conn
    puts '///////////////////////////////////////'
    respond_to do |format|
      if @serv.save
        format.html { redirect_to servs_url, notice: t('servs.create.notice')  }
        format.json { render json: @serv, status: :created, location: @serv }
      else
        @net_eles = NetEle.all
        format.html { render action: "new" }
        format.json { render json: @serv.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /servs/1
  # PUT /servs/1.json
  def update
    @serv = Serv.find(params[:id])
    @conn = @serv.conn
    @serv2 = Serv.new(params[:serv])
    if @serv2.mother
      params[:serv][:domain]= @serv2.mother.name
      params[:serv][:mother]=@serv2.mother
      params[:serv][:conn][:ip]=@serv2.mother.conn.ip
    else
      params[:serv][:domain]=nil
      params[:serv][:mother]=nil
      params[:serv][:conn][:ip]=nil
    end
    pass1=@conn.update_attributes(params[:serv][:conn])
    pass2=@serv.update_attributes(params[:serv])
    respond_to do |format|
      if pass1 and pass2
        format.html { redirect_to servs_url, notice: t('servs.update.notice')  }
        format.json { head :no_content }
      else
        @net_eles = NetEle.all
        format.html { render action: "edit" }
        format.json { render json: @serv.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /servs/1
  # DELETE /servs/1.json
  def destroy
    @serv = Serv.find(params[:id])
    @serv.destroy

    respond_to do |format|
      format.html { redirect_to servs_url, notice: t('servs.delete.notice')   }
      format.json { head :no_content }
    end
  end

  def testconn
    @m='No hay conexión'
    @cs='error'
    repo=params['repo']
    port=params['port']
    if repo != ""
      @netele = NetEle.find_by(:_id => repo)
      ip=@netele.conn.ip
      if self.is_port_open?(ip,port)
        @m='Conexión exitosa'
        @cs='success'
      end
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
