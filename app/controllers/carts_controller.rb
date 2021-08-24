class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  def index
    @cart_items = session[:cart]
    @ordered_items = {}
    @total = 0
    @cart_items.each do |item_id, qty|
        item = Item.find_by(id: item_id)
        @ordered_items[item_id] = {item: item, qty: qty}
        check_status(item, qty, item_id)
    end unless session[:cart].nil?
    session[:order]["items"] = @ordered_items
  end

  def destroy
      item_id = params[:id]
      @cart.cart_data.delete(item_id)
      redirect_to carts_path
  end

  def check_status(item, qty, item_id)
      if item.flag == true
          @total += qty * item.price
      else
          @ordered_items.delete(item_id)
      end
  end

  def show
    @cart = current_cart
  end

  def add_to_cart
    current_cart.add_item(params[:item_id])
  end

  def new
    @carts = current_cart
  end

  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
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
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
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
