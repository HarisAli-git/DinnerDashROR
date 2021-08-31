# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    user = User.find(params[:id])
    @orders = @user.orders
  end

  def show
    @user = User.find(params[:id])
    @orders = @user.orders
  end

  def create
    user = User.create!(user_params)
    session[:user_id] = user.id
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :username, :email, :encrypted_password)
    end
end
