class AlrMntrRngsController < ApplicationController
  # GET /alr_mntr_rngs
  # GET /alr_mntr_rngs.json
  def index
    @alr_mntr_rngs = AlrMntrRng.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alr_mntr_rngs }
    end
  end

  # GET /alr_mntr_rngs/1
  # GET /alr_mntr_rngs/1.json
  def show
    @alr_mntr_rng = AlrMntrRng.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alr_mntr_rng }
    end
  end

  # GET /alr_mntr_rngs/new
  # GET /alr_mntr_rngs/new.json
  def new
    @alr_mntr_rng = AlrMntrRng.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alr_mntr_rng }
    end
  end

  # GET /alr_mntr_rngs/1/edit
  def edit
    @alr_mntr_rng = AlrMntrRng.find(params[:id])
  end

  # POST /alr_mntr_rngs
  # POST /alr_mntr_rngs.json
  def create
    @alr_mntr_rng = AlrMntrRng.new(params[:alr_mntr_rng])

    respond_to do |format|
      if @alr_mntr_rng.save
        format.html { redirect_to @alr_mntr_rng, notice: 'Alr mntr rng was successfully created.' }
        format.json { render json: @alr_mntr_rng, status: :created, location: @alr_mntr_rng }
      else
        format.html { render action: "new" }
        format.json { render json: @alr_mntr_rng.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /alr_mntr_rngs/1
  # PUT /alr_mntr_rngs/1.json
  def update
    @alr_mntr_rng = AlrMntrRng.find(params[:id])

    respond_to do |format|
      if @alr_mntr_rng.update_attributes(params[:alr_mntr_rng])
        format.html { redirect_to @alr_mntr_rng, notice: 'Alr mntr rng was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @alr_mntr_rng.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alr_mntr_rngs/1
  # DELETE /alr_mntr_rngs/1.json
  def destroy
    @alr_mntr_rng = AlrMntrRng.find(params[:id])
    @alr_mntr_rng.destroy

    respond_to do |format|
      format.html { redirect_to alr_mntr_rngs_url }
      format.json { head :no_content }
    end
  end
end
