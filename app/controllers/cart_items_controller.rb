# frozen_string_literal: true

class CartItemsController < ApplicationController
  def create
    @cart.increment(params[:item_id])
    session[:cart] = @cart.cart_data
    redirect_to items_path
  end

  def destroy
    @cart.cart_data.delete(params[:id])
    redirect_to carts_path
    puts "des" * 100
    puts params[:id].inspect
    # @cart.destroy
    # session.delete(:cart)
  end

  def delete
    # @cart.delete(:item_id)
    # redirect_to carts_path
  end

  def update
    # cart = cart_params
    # item_id = cart[:item_id]
    # quantity = cart[:quantity]
    # session[:cart][item_id] = quantity.to_i
    # session[:order]["items"][item_id]["quantity"] = quantity.to_i
    # session[:order]["details"] = order_params
    # render json: { data: item_id }
    puts "=" * 100
    puts params.inspect
    puts params[:item_id]
    puts "=" * 100

    if params[:quantity].keys[0].to_i < params[:quantity].values[0].to_i
      (params[:quantity].keys[0].to_i + 1..params[:quantity].values[0].to_i).each do |_i|
        @cart.increment(params[:item_id])
      end
      redirect_to carts_path
    elsif params[:quantity].keys[0].to_i > params[:quantity].values[0].to_i
      (params[:quantity].values[0].to_i + 1..params[:quantity].keys[0].to_i).each do |_i|
        @cart.decrement(params[:item_id])
      end
      redirect_to carts_path
    end
  end

  private
    def cart_params
      params.require(:cart_items).permit(:item_id, :quantity)
    end

    def order_params
      params.require(:order_details).permit(:total)
    end
end
