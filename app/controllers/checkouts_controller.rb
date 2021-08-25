# frozen_string_literal: true

class CheckoutsController < ApplicationController
  def index; end

  def create
    @current_order.update_order(session[:order], status: params[:status])
    puts '='*100
    puts @current_user.inspect
    puts '='*100
    if @current_order.save_order(@current_user)
      session[:order] = {}
      session[:cart] = {}
      redirect_to root_path 
    end
  end

end
