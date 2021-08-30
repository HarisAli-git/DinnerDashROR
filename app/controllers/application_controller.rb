# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  attr_reader :cart
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :current_user
  before_action :load_cart
  before_action :load_cart_order

  def load_cart
    @cart ||= Cart.new(session[:cart])
  end

  def load_cart_order
    session[:order] ||= {}
    @current_order ||= CurrentOrder.new(session[:order])
  end

  protected
    def configure_permitted_parameters
      attributes = %i[name username email encrypted_password password_confirmation]
      devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
      devise_parameter_sanitizer.permit(:account_update, keys: attributes)
    end
end
