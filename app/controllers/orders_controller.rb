# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @line_items = @order.line_items
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    authorize @order
    if @order.status == 1
      @order.update(status: 0)
      redirect_to @order
    else
      @order.status = 1
      @order.save
      redirect_to @order
    end
  end
end
