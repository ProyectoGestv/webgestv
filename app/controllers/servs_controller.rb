class ServsController < ApplicationController
  # GET /servs
  # GET /servs.json
  def index
    @servs = Serv.all

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
      format.html # show.html.erb
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
        format.html { redirect_to servs_url, notice: 'Create at least one Net Ele.'  }
        format.json { render json: @servs.errors, status: :unprocessable_entity }
      end
    end

  end

  # GET /servs/1/edit
  def edit
    @serv = Serv.find(params[:id])
    @repoid=@serv.mother.id
    @net_eles = NetEle.all
    @conn = @serv.conn
  end

  # POST /servs
  # POST /servs.json
  def create
    @serv = Serv.new(params[:serv])
    params[:conn][:ip]=@serv.mother.conn.ip
    @conn=Conn.new(params[:conn])
    @serv.conn=@conn
    respond_to do |format|
      if @serv.save
        format.html { redirect_to servs_url, notice: 'Serv was successfully created.'  }
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
    params[:serv][:mother]=@serv2.mother
    params[:conn][:ip]=@serv2.mother.conn.ip

    respond_to do |format|
      if @conn.update_attributes(params[:conn]) and @serv.update_attributes(params[:serv])
        format.html { redirect_to servs_url, notice: 'Serv was successfully updated.'  }
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
      format.html { redirect_to servs_url, notice: 'Serv was successfully deleted.'   }
      format.json { head :no_content }
    end
  end
end
