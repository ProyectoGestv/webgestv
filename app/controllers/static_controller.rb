# -*- encoding : utf-8 -*-
class StaticController < ApplicationController
  skip_before_filter :authenticate_user!
  def index
    @users = User.all
  end
end
