class CartsController < ApplicationController
  def index
    @cart_items = session[:cart]
    @line_items = {}
    @tot_items = 0
    @cart_items.each do |item_id, quantity|
        item = Item.find_by(id: item_id)
        @line_items[item_id] = {item: item, quantity: quantity}
        check_status(item, quantity, item_id)
    end unless session[:cart].nil?
    @current_order.line_items = @line_items
    session[:order]["items"] = @line_items
  end

  def destroy
    item_id = params[:id]
    @cart.cart_data.delete(item_id)
    redirect_to carts_path
  end

  def check_status(item, qty, item_id)
    if item.flag == true
        @tot_items = @tot_items + @qty * item.price
    else
        @line_items.delete(item_id)
    end
  end
end
