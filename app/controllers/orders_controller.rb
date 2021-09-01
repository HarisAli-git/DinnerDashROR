# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    if current_user.is_Admin?
      @line_items = @order.line_items
    elsif @order.user_id == current_user.id
      @line_items = @order.line_items
    else
      respond_to do |format|
        format.html { redirect_to root_path, notice: "You don't have permission." }
      end
    end
  end

  def edit
    @order = Order.find(params[:id])
    begin 
      authorize @order
    rescue Pundit::NotAuthorizedError
      respond_to do |format|
        format.html { redirect_to root_path, notice: "You don't have permission." }
      end
      return
    end
  end

  def update
    @order = Order.find(params[:id])
    authorize @order
    if @order.status == 1
      @order.update(status: 2)
      redirect_to @order
    elsif @order.status == 0
      @order.status = 2
      @order.save
      redirect_to @order
    else
      @order.status = 2
      @order.save
      redirect_to @order
    end
  end
end
