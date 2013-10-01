# -*- encoding : utf-8 -*-
require 'net/http'

class NetElesController < ApplicationController
  # GET /net_eles
  # GET /net_eles.json
  def index
    @net_eles = NetEle.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @net_eles }
    end
  end

  # GET /net_eles/1
  # GET /net_eles/1.json
  def show
    @net_ele = NetEle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @net_ele }
    end
  end

  # GET /net_eles/new
  # GET /net_eles/new.json
  def new
    @net_ele = NetEle.new
    @net_ele.conn=Conn.new
#    @net_ele.conn=@conn
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @net_ele }
    end
  end

  # GET /net_eles/1/edit
  def edit
    @net_ele = NetEle.find(params[:id])
    @conn = @net_ele.conn
  end

  # POST /net_eles
  # POST /net_eles.json
  def create
    params[:net_ele][:domain]='SNMPIntegrationServer'
    @net_ele = NetEle.new(params[:net_ele])
    respond_to do |format|
      if @net_ele.save
        format.html { redirect_to net_eles_url, notice: t('net_eles.create.notice')  }
        format.json { render json: @net_ele, status: :created, location: @net_ele }
      else
        format.html { render action: "new" }
        format.json { render json: @net_ele.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /net_eles/1
  # PUT /net_eles/1.json
  def update
    @net_ele = NetEle.find(params[:id])
    oldname=@net_ele.name
    oldip=@net_ele.conn.ip
    oldport=@net_ele.conn.port
    pass=@net_ele.update_attributes(params[:net_ele])
    respond_to do |format|
      if pass
        if @net_ele.mngbl
          #Si se modifico algo se reinicia el MR a través de los llamados a webservices registrar y remover del núcleo
          http = Net::HTTP.new("192.168.119.35",9999)
          post_params = {'ip' => oldip, 'port' => oldport}
          request = Net::HTTP::Delete.new("/mbs/#{@net_ele.domain}/#{oldname}")
          request.set_form_data(post_params)
          begin
            response = http.request(request)
          rescue Errno::ECONNREFUSED
          end
          post_params = {'ip' => @net_ele.conn.ip, 'port' => @net_ele.conn.port, 'domain' => @net_ele.domain, 'type' => @net_ele.name}
          request = Net::HTTP::Post.new("/mbs/register")
          request.set_form_data(post_params)
          begin
            response = http.request(request)
          rescue Errno::ECONNREFUSED
          end
        end
        newname=@net_ele.name
        modify_links(oldname,newname)
        @net_ele.children.each do |h|
          if h.mngbl
            #Si se modifico algo se remueve el MR hijo a través del llamado al webservice remover del núcleo
            http = Net::HTTP.new("192.168.119.35",9999)
            post_params = {'ip' => h.conn.ip, 'port' => h.conn.port}
            request = Net::HTTP::Delete.new("/mbs/#{h.domain}/#{h.name}")
            request.set_form_data(post_params)
            begin
              response = http.request(request)
            rescue Errno::ECONNREFUSED
            end
          end
          h.conn.ip=@net_ele.conn.ip
          h.save
          if h.mngbl
            #Si se modifico algo se registra de nuevo el MR hijo a través del llamado al webservice registrar del núcleo
            post_params = {'ip' => h.conn.ip, 'port' => h.conn.port, 'domain' => h.domain, 'type' => h.name}
            request = Net::HTTP::Post.new("/mbs/register")
            request.set_form_data(post_params)
            begin
              response = http.request(request)
            rescue Errno::ECONNREFUSED
            end
          end
        end
        format.html { redirect_to net_eles_url, notice: t('net_eles.update.notice')  }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @net_ele.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /net_eles/1
  # DELETE /net_eles/1.json
  def destroy
    @net_ele = NetEle.find(params[:id])
    begin
      @net_ele.destroy
      respond_to do |format|
        format.html { redirect_to net_eles_url, notice: t('net_eles.delete.notice')   }
        format.json { head :no_content }
      end
    rescue Mongoid::Errors::DeleteRestriction
      respond_to do |format|
        format.html { redirect_to net_eles_url, notice: t('net_eles.delete.error_ch')  }
        format.json { render json: @net_ele.errors, status: :unprocessable_entity }
      end
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
