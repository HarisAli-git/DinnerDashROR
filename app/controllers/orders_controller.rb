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
    if @order.status == true
      @order.status = 0
      @order.update(status: 0)
      redirect_to @order
    else
      @order.status = true
      @order.save
      redirect_to @order
    end
  end
end
