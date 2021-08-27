# frozen_string_literal: true

class CartItemsController < ApplicationController
  def create
    @current_cart.increment(params[:item_id])
    session[:cart] = @current_cart.cart_data
    redirect_to items_path
  end

  def destroy
    @current_cart.cart_data.delete
    redirect_to carts_path
  end

  def delete
    @current_cart.delete(:item_id)
    redirect_to carts_path
  end

  def update
    cart = cart_params
    item_id = cart[:item_id]
    quantity = cart[:quantity]
    session[:cart][item_id] = quantity.to_i
    session[:order]["items"][item_id]["quantity"] = quantity.to_i
    session[:order]["details"] = order_params
    render json: { data: item_id }
  end

  private
    def cart_params
      params.require(:cart_items).permit(:item_id, :quantity)
    end

    def order_params
      params.require(:order_details).permit(:total)
    end
end
