class CartsController < ApplicationController
    def index
    end

    def show
        @cart = Cart.find(params[:id])
    end

    def create
      @cart = Cart.new(cart_params)
    
      if @cart.save
        redirect_to @cart
      else
        render :new
      end
    end

    def update
      @cart = Cart.find(params[:id])

      if @cart.update(cart_params)
        redirect_to @cart
      else
        render :edit
      end
    end
    
    def destroy
      @cart = Cart.find(params[:id])
      @cart.destroy

      redirect_to root_path
    end

    private
    def cart_params
      params.require(:cart).permit(:user_id)
    end
end
