class ApplicationController < ActionController::Base
    
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  before_action :current_cart
  before_action :load_cart

  helper_method :c_cart

  
  def current_cart
    @current_cart ||= Cart.new(session[:cart_id])
  end

  def load_cart
      session[:order] ||= {}
      @current_order ||= {}
  end

  def c_cart
    @current_cart
  end


  protected
  
  def configure_permitted_parameters
    attributes = [:name, :username, :email, :encrypted_password, :password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

end
