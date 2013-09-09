class AtrHstsController < ApplicationController
  # GET /atr_hsts
  # GET /atr_hsts.json
  def index
    @atr_hsts = AtrHst.all

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @atr_hsts }
    end
  end

  # GET /atr_hsts/1
  # GET /atr_hsts/1.json
  def show
    @atr_hst = AtrHst.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @atr_hst }
    end
  end

  # GET /atr_hsts/new
  # GET /atr_hsts/new.json
  def new
    @atr_hst = AtrHst.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @atr_hst }
    end
  end

  # GET /atr_hsts/1/edit
  def edit
    @atr_hst = AtrHst.find(params[:id])
  end

  # POST /atr_hsts
  # POST /atr_hsts.json
  def create
    @atr_hst = AtrHst.new(params[:atr_hst])
    @atr_hst.atr=Atr.first
    @atr_hst.value='25000'
    @atr_hst.tstamp=Time.now.to_i
    respond_to do |format|
      if @atr_hst.save
        format.html { redirect_to @atr_hst, notice: 'Atr hst was successfully created.' }
        format.json { render json: @atr_hst, status: :created, location: @atr_hst }
      else
        format.html { render action: "new" }
        format.json { render json: @atr_hst.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /atr_hsts/1
  # PUT /atr_hsts/1.json
  def update
    @atr_hst = AtrHst.find(params[:id])

    respond_to do |format|
      if @atr_hst.update_attributes(params[:atr_hst])
        format.html { redirect_to @atr_hst, notice: 'Atr hst was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @atr_hst.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /atr_hsts/1
  # DELETE /atr_hsts/1.json
  def destroy
    @atr_hst = AtrHst.find(params[:id])
    @atr_hst.destroy

    respond_to do |format|
      format.html { redirect_to atr_hsts_url }
      format.json { head :no_content }
    end
  end
end
