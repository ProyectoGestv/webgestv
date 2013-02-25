class ManRscsController < ApplicationController
  # GET /man_rscs
  # GET /man_rscs.json
  def index
    @man_rscs = ManRsc.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @man_rscs }
    end
  end

  # GET /man_rscs/1
  # GET /man_rscs/1.json
  def show
    @man_rsc = ManRsc.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @man_rsc }
    end
  end

  # GET /man_rscs/new
  # GET /man_rscs/new.json
  def new
    @man_rsc = ManRsc.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @man_rsc }
    end
  end

  # GET /man_rscs/1/edit
  def edit
    @man_rsc = ManRsc.find(params[:id])
  end

  # POST /man_rscs
  # POST /man_rscs.json
  def create
    @man_rsc = ManRsc.new(params[:man_rsc])

    respond_to do |format|
      if @man_rsc.save
        format.html { redirect_to @man_rsc, notice: 'Man rsc was successfully created.' }
        format.json { render json: @man_rsc, status: :created, location: @man_rsc }
      else
        format.html { render action: "new" }
        format.json { render json: @man_rsc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /man_rscs/1
  # PUT /man_rscs/1.json
  def update
    @man_rsc = ManRsc.find(params[:id])

    respond_to do |format|
      if @man_rsc.update_attributes(params[:man_rsc])
        format.html { redirect_to @man_rsc, notice: 'Man rsc was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @man_rsc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /man_rscs/1
  # DELETE /man_rscs/1.json
  def destroy
    @man_rsc = ManRsc.find(params[:id])
    @man_rsc.destroy

    respond_to do |format|
      format.html { redirect_to man_rscs_url }
      format.json { head :no_content }
    end
  end
end
