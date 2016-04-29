class CategoriesController < ApplicationController

  def index
    @c = current_user.categories
  end

  def new
    @c = Category.new()
  end

  def create
    c = current_user.categories.create(category_params_permit)
    redirect_to categories_path
  end

  def edit
    @c = Category.find(params[:id])
  end

  def update
    c = Category.find(params[:id])
    c.update(category_params_permit)
    redirect_to categories_path
  end

  def destroy
    Category.find(params[:id]).destroy
    redirect_to categories_path
  end

  private

  def category_params_permit
    params.require(:category).permit(:name)
  end

end
