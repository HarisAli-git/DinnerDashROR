# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :set_select_collections, only: %i[edit update new create]

  def index
    @items = policy_scope(Item).all
    @categories = Category.all
  end

  def show
    begin
      @item = Item.find(params[:id])
    rescue NoMethodError
      respond_to do |format|
        format.html { redirect_to root_path, notice: "This is an out-of-stock item. You don't have permission to view it." }
      end
      return
    end
    @categories = Category.all
    begin
      if !current_user.is_Admin
        if !@item.flag  
          respond_to do |format|
            format.html { redirect_to root_path, notice: "This is an out-of-stock item. You don't have permission to view it." }
          end
        end
      end
    rescue NoMethodError
      respond_to do |format|
        format.html { redirect_to root_path, notice: "You don't have permission" }
      end
      return
    end
  end

  def new
    @item = Item.new
    @categories = Category.all
  end

  def create
    @item = Item.new(item_params)
    begin 
      authorize @item
    rescue Pundit::NotAuthorizedError
      respond_to do |format|
        format.html { redirect_to root_path, notice: "You don't have permission." }
      end
      return
    end
    if @item.save
      @item_category = ItemCategory.new(item_id: @item.id, category_id: params[:item][:category_ids])
      @item_category.save
      @categories = Category.all
      redirect_to @item
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
    @categories = Category.all
    begin 
      authorize @item
    rescue Pundit::NotAuthorizedError
      respond_to do |format|
        format.html { redirect_to root_path, notice: "You don't have permission." }
      end
      return
    end
  end

  def update_status
    item = Item.find(params[:item_id].to_i)
    authorize item
    unless item.nil?
      flag = item_params[:flag] != "true"
      item.flag = flag
      item.save
      redirect_to item
    else
      render :edit
    end
  end

  def update
    @item = Item.find(params[:id])
    authorize @item
    if @item.update(item_params)
      @item_categories = @item.item_categories
      @item_categories.update(category_id: params[:item][:category_ids])
      redirect_to @item
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    authorize @item
    @item.destroy
    redirect_to items_path
  end

  private
    def item_params
      params.require(:item).permit(:title, :description, :price, :flag, :avatar)
    end

    def set_select_collections
      @categories = Category.all
    end
end
