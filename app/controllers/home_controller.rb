# frozen_string_literal: true

class HomeController < ApplicationController
  def index; 
    @user = User.where(id: current_user.id).take! if user_signed_in?
  end

  def about; end
end
