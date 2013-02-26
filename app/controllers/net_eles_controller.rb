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
#    @conn=Conn.new
#    @net_ele.conn=@conn
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @net_ele }
    end
  end

  # GET /net_eles/1/edit
  def edit
    @net_ele = NetEle.find(params[:id])
  end

  # POST /net_eles
  # POST /net_eles.json
  def create
    @conn=Conn.new(params[:conn])
    @net_ele = NetEle.new(params[:net_ele])
    @net_ele.conn=@conn
    respond_to do |format|
      if @net_ele.save
        format.html { redirect_to @net_ele, notice: 'Net ele was successfully created.' }
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

    respond_to do |format|
      if @net_ele.update_attributes(params[:net_ele])
        format.html { redirect_to @net_ele, notice: 'Net ele was successfully updated.' }
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
    @net_ele.destroy

    respond_to do |format|
      format.html { redirect_to net_eles_url }
      format.json { head :no_content }
    end
  end
end
