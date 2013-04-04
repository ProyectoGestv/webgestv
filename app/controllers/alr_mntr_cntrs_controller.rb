class AlrMntrCntrsController < ApplicationController
  # GET /alr_mntr_cntrs
  # GET /alr_mntr_cntrs.json
  def index
    @alr_mntr_cntrs = AlrMntrCntr.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alr_mntr_cntrs }
    end
  end

  # GET /alr_mntr_cntrs/1
  # GET /alr_mntr_cntrs/1.json
  def show
    @alr_mntr_cntr = AlrMntrCntr.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alr_mntr_cntr }
    end
  end

  # GET /alr_mntr_cntrs/new
  # GET /alr_mntr_cntrs/new.json
  def new
    session[:return_to]=request.referer
    puts params
    puts '///////////////////////////////////////'
    session[:serv_id]=params[:serv_id]
    session[:mcr_atr_id]=params[:mcr_atr_id]
    session[:atr_id]=params[:atr_id]
    session[:alr_cat]=params[:alr_cat]
    @alr_mntr_cntr = AlrMntrCntr.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alr_mntr_cntr }
    end
  end

  # GET /alr_mntr_cntrs/1/edit
  def edit
    @alr_mntr_cntr = AlrMntrCntr.find(params[:id])
  end

  # POST /alr_mntr_cntrs
  # POST /alr_mntr_cntrs.json
  def create
    puts params
    puts session[:atr_id]
    puts '///////////////////////////////////////'
    @alr_mntr_cntr = AlrMntrCntr.new(params[:alr_mntr_cntr])
    atr=Atr.find(session[:atr_id])
    atr.qos_mon=@alr_mntr_cntr
    @alr_mntr_cntr.atr=atr
    puts atr.to_xml
    puts @alr_mntr_cntr.to_xml
    #atr.qos_mon=@alr_mntr_cntr
    #puts atr.to_xml
    respond_to do |format|
      if @alr_mntr_cntr.save
        format.html { redirect_to session[:return_to], notice: 'Alr mntr cntr was successfully created.' }
        format.json { render json: @alr_mntr_cntr, status: :created, location: @alr_mntr_cntr }
      else
        format.html { render action: "new" }
        format.json { render json: @alr_mntr_cntr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /alr_mntr_cntrs/1
  # PUT /alr_mntr_cntrs/1.json
  def update
    @alr_mntr_cntr = AlrMntrCntr.find(params[:id])

    respond_to do |format|
      if @alr_mntr_cntr.update_attributes(params[:alr_mntr_cntr])
        format.html { redirect_to @alr_mntr_cntr, notice: 'Alr mntr cntr was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @alr_mntr_cntr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alr_mntr_cntrs/1
  # DELETE /alr_mntr_cntrs/1.json
  def destroy
    puts params
    puts '///////////////////////////////////////'
    #@alr_mntr_cntr = AlrMntrCntr.find(params[:id])
    @alr_mntr_cntr = Atr.find(params[:atr_id]).qos_mon
    @alr_mntr_cntr.destroy

    respond_to do |format|
      format.html { redirect_to :back, notice: 'Alr mntr cntr was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
