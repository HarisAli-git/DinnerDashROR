# frozen_string_literal: true

class AdminsController < ApplicationController
  def index
    @user = User.where(id: current_user.id).take! if user_signed_in?
  end

  def show; end

  def get_orders; end

  def get_items; end

  def get_users; end
end
