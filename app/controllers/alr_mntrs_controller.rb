class AlrMntrsController < ApplicationController
  # GET /alr_mntrs
  # GET /alr_mntrs.json
  def index
    @alr_mntrs = AlrMntr.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alr_mntrs }
    end
  end

  # GET /alr_mntrs/1
  # GET /alr_mntrs/1.json
  def show
    @alr_mntr = AlrMntr.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alr_mntr }
    end
  end

  # GET /alr_mntrs/new
  # GET /alr_mntrs/new.json
  def new
    session[:return_to]=request.referer
    puts params
    puts '///////////////////////////////////////'

    @alr_mntr = AlrMntr.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alr_mntr }
    end
  end

  # GET /alr_mntrs/1/edit
  def edit
    @alr_mntr = AlrMntr.find(params[:id])
  end

  # POST /alr_mntrs
  # POST /alr_mntrs.json
  def create
    puts params
    puts '///////////////////////////////////////'
    @alr_mntr = AlrMntr.new(params[:alr_mntr])

    respond_to do |format|
      if @alr_mntr
        format.html { redirect_to @alr_mntr, notice: 'Alr mntr was successfully created.' }
        format.json { render json: @alr_mntr, status: :created, location: @alr_mntr }
      else
        format.html { render action: "new" }
        format.json { render json: @alr_mntr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /alr_mntrs/1
  # PUT /alr_mntrs/1.json
  def update
    @alr_mntr = AlrMntr.find(params[:id])

    respond_to do |format|
      if @alr_mntr.update_attributes(params[:alr_mntr])
        format.html { redirect_to @alr_mntr, notice: 'Alr mntr was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @alr_mntr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alr_mntrs/1
  # DELETE /alr_mntrs/1.json
  def destroy
    @alr_mntr = AlrMntr.find(params[:id])
    @alr_mntr.destroy

    respond_to do |format|
      format.html { redirect_to alr_mntrs_url }
      format.json { head :no_content }
    end
  end
end
