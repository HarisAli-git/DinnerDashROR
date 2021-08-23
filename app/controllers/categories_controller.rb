class CategoriesController < ApplicationController
    def index
        @category = Category.all
    end

    def show
        @category = Category.find(params[:id])
    end

    def new
        @category = Category.new
    end

    def create
        @category = Category.new(cat_params)
        authorize @category

        if @category.save
            redirect_to @category
        else
            render :new
        end
    end

    def edit
    @category = Category.find(params[:id])
    end

    def update
    @category = Category.find(params[:id])
    authorize @category
    if @category.update(cat_params)
        redirect_to @category
    else
        render :edit
    end
    end

    def destroy
    @category = Category.find(params[:id])
    authorize @category
    @category.destroy
    redirect_to root_path
    end

    private
    def cat_params
        params.require(:category).permit(:name)
    end
end
