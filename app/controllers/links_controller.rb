# -*- encoding : utf-8 -*-
class LinksController < ApplicationController
  # GET /links
  # GET /links.json
  def index
    @links = Link.all

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @links }
    end
  end

  # GET /links/1
  # GET /links/1.json
  def show
    @link = Link.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @link }
    end
  end

  # GET /links/new
  # GET /links/new.json
  def new
    @link = Link.new
    @links_a=ManRsc.all
    @links_b=@links_a
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @link }
    end
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(params[:link])
    puts "////////////////////////////"
    puts params
    respond_to do |format|
      if @link.save
        format.html { redirect_to links_url, notice: t('links.create.notice') }
        format.json { render json: @link, status: :created, location: @link }
      else
        @links_a=ManRsc.all
        @links_b=linksb(params[:link][:link_a])
        format.html { render action: "new" }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link = Link.find(params[:id])
    @link.destroy

    respond_to do |format|
      format.html { redirect_to links_url }
      format.json { head :no_content }
    end
  end

  def update_linksb
    @link = Link.new
    inc=false
    #if params[:action] == "edit" or params[:action] == "update"
      #inc = true
    #end
    @links_b=linksb(params[:name])
    render :partial => "linksb", :link => @links_b
  end

  def linksb(name)
    linksb=ManRsc.excludes(name: name)
    puts "////////////////////////////////"
    puts linksb.as_json
    links_b=[]
    nob=Link.where(link_a: name)
    lb=[]
    nob.each do |a|
      lb << a.link_b
    end
    noa=Link.where(link_b: name)
    noa.each do |a|
      lb << a.link_a
    end
    #puts "////////////////////////////////"
    #puts lb
    linksb.each do |a|
      if not lb.include?(a.name)
        links_b << a
      end
    end
    links_b
  end

end
