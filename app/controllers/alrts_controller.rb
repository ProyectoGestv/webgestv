class AlrtsController < ApplicationController
  # GET /alrts
  # GET /alrts.json
  def index
    @alrts = Alrt.all.order_by(:created_at.desc)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alrts }
    end
  end

  # GET /alrts/1
  # GET /alrts/1.json
  def show
    @alrt = Alrt.find(params[:id])

    respond_to do |format|
      format.html # _edit_multiple.html.erb
      format.json { render json: @alrt }
    end
  end

  # GET /alrts/new
  # GET /alrts/new.json
  def new
    @alrt = Alrt.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alrt }
    end
  end

  # GET /alrts/1/edit
  def edit
    @alrt = Alrt.find(params[:id])
  end

  # POST /alrts
  # POST /alrts.json
  def create
    @alrt = Alrt.new(params[:alrt])

    respond_to do |format|
      if @alrt.save
        format.html { redirect_to @alrt, notice: 'Alrt was successfully created.' }
        format.json { render json: @alrt, status: :created, location: @alrt }
      else
        format.html { render action: "new" }
        format.json { render json: @alrt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /alrts/1
  # PUT /alrts/1.json
  def update
    @alrt = Alrt.find(params[:id])

    respond_to do |format|
      if @alrt.update_attributes(params[:alrt])
        format.html { redirect_to @alrt, notice: 'Alrt was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @alrt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alrts/1
  # DELETE /alrts/1.json
  def destroy
    @alrt = Alrt.find(params[:id])
    @alrt.destroy

    respond_to do |format|
      format.html { redirect_to alrts_url }
      format.json { head :no_content }
    end
  end
end
