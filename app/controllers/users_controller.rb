# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: 'Usuario creado satisfactoriamente.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'Usuario modificado satisfactoriamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    count=0
    User.all.each do |user|
      if user.role=='admin'
        count+=1
      end
    end
    puts '////////////////////////////////'
    puts count
    puts @user.role
    puts '////////////////////////////////'
    if current_user._id==@user._id
      respond_to do |format|
        format.html { redirect_to users_url, alert: 'No puede eliminar su propia cuenta.' }
        format.json { head :no_content }
      end
    else
      if count==1 && @user.role=="admin"
        respond_to do |format|
          format.html { redirect_to users_url, alert: 'No se puede borrar el último administrador.' }
          format.json { head :no_content }
        end
      else
        @user.destroy
        respond_to do |format|
          format.html { redirect_to users_url, notice: 'Usuario eliminado satisfactoriamente.' }
          format.json { head :no_content }
        end
      end
    end
  end
end
