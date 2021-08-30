# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_cart, only: %i[show edit update destroy]

  def index
    @cart_items = session[:cart]
    @line_items = {}
    @total = 0
    # if @cart_items.has_key?("item_id")
    #   @cart_items.delete "item_id"
    # end
    unless session[:cart].nil?
    @total = 0
      @cart_items.each do |item_id, quantity|
        item = Item.find_by(id: item_id)
        @line_items[item_id] = { item: item, quantity: quantity }
        if item.flag == true
          @total += (quantity * item.price)
        else
          @line_items.delete(item_id)
        end
      end
    end
    session[:order]["items"] = @line_items
  end

  def destroy
    session[:cart] = {}
    redirect_to carts_path
  end

  def show
    @cart = cart
  end

  def add_to_cart
    cart.add_item(params[:item_id])
  end

  def new
    @carts = cart
  end

  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: "Cart was successfully created." }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: "Cart was successfully updated." }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def invalid_cart
    logger.error "Attempt to access illegal cart #{params[:id]}"
    redirect_to root_path, notice: "Invalid Cart Access"
  end

  private
    def set_cart
      @cart = Cart.find(params[:id])
    end

    def cart_params
      params.fetch(:cart, {})
    end
end
