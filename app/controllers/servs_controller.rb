# -*- encoding : utf-8 -*-
require 'net/http'

class ServsController < ApplicationController
  # GET /servs
  # GET /servs.json
  def index
    @servs = Serv.all.order_by(:name.asc)

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @servs }
    end
  end

  # GET /servs/1
  # GET /servs/1.json
  def show
    @serv = Serv.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @serv }
    end
  end

  # GET /servs/new
  # GET /servs/new.json
  def new
    @serv = Serv.new
    @serv.conn=Conn.new
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
    @serv = Serv.new(params[:serv])
    if @serv.mother
      @serv.conn.ip=@serv.mother.conn.ip
      @serv.domain=@serv.mother.name
    end

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
    olddomain=@serv.domain
    oldname=@serv.name
    oldip=@serv.conn.ip
    oldport=@serv.conn.port
    @serv2 = Serv.new(params[:serv])
    if @serv2.mother
      params[:serv][:domain]= @serv2.mother.name
      params[:serv][:mother]=@serv2.mother
      params[:serv][:conn][:ip]=@serv2.mother.conn.ip
    else
      params[:serv][:domain]=nil
      params[:serv][:mother]=nil
      params[:serv][:conn][:ip]=''
    end
    pass=@serv.update_attributes(params[:serv])

    if pass
      if @serv.mngbl
        #Si se modifico algo se reinicia el MR a través de los llamados a webservices registrar y remover del núcleo
        http = Net::HTTP.new("192.168.119.35",9999)
        post_params = {'ip' => oldip, 'port' => oldport}
        request = Net::HTTP::Delete.new("/mbs/#{olddomain}/#{oldname}")
        request.set_form_data(post_params)
        begin
          response = http.request(request)
        rescue Errno::ECONNREFUSED
        end
        post_params = {'ip' => @serv.conn.ip, 'port' => @serv.conn.port, 'domain' => @serv.domain, 'type' => @serv.name}
        request = Net::HTTP::Post.new("/mbs/register")
        request.set_form_data(post_params)
        begin
          response = http.request(request)
        rescue Errno::ECONNREFUSED
        end
      end
    end
    respond_to do |format|
      if pass
        newname=@serv.name
        modify_links(oldname,newname)
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
    if @serv.mngbl
      #Remueve el MR a través de una llamada al webservice del núcleo
      http = Net::HTTP.new("192.168.119.35",9999)
      post_params = {'ip' => @serv.conn.ip, 'port' => @serv.conn.port}
      request = Net::HTTP::Delete.new("/mbs/#{@serv.domain}/#{@serv.name}")
      request.set_form_data(post_params)
      begin
        response = http.request(request)
      rescue Errno::ECONNREFUSED
      end
    end
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

  def modify_links(oldname,newname)
    Link.all.each do |link|
      if link.link_a==oldname
        link.link_a=newname
        link.save!
      end
      if link.link_b==oldname
        link.link_b=newname
        link.save!
      end
    end
  end

end
