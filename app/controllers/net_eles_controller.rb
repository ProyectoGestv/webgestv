# -*- encoding : utf-8 -*-
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
    @conn=Conn.new
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
    @conn=Conn.new(params[:conn])
    @net_ele = NetEle.new(params[:net_ele])
    @net_ele.conn=@conn
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
    @conn = @net_ele.conn
    respond_to do |format|
      if @conn.update_attributes(params[:conn]) and @net_ele.update_attributes(params[:net_ele])
        @net_ele.children.each do |h|
          h.conn.ip=@conn.ip
          h.save
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

  def sauce
    ip=params['ip']
    port=params['port']
    a=""
    if self.is_port_open?(ip,port)
      puts "//////////////////////////////////////v"
      a="Conexión exitosa"
    else
      puts "//////////////////////////////////////f"
      a="No hay conexión"
    end
    respond_to do |format|
      format.js { render :js => "alert('#{a}')" }
    end
  end

  def is_port_open?(ip, port)
    puts "//////////////////////////////////////e"
    begin
      Timeout::timeout(1) do
        begin
          puts "//////////////////////////////////////"
          s = TCPSocket.new(ip, port)
          s.close
          puts "it works"
          puts "//////////////////////////////////////"
          return true
        rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
          puts "dont work"
          puts "//////////////////////////////////////"
          return false
        end
      end
    rescue Timeout::Error
    end

    return false
  end
end
