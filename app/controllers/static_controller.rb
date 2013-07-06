# -*- encoding : utf-8 -*-
class StaticController < ApplicationController
  def index
    @users = User.all
  end
end
