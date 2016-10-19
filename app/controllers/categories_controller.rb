class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    session[:welcome_categorization] = false
    @categories = current_user.categories
  end

  def new
    @category = Category.new()
  end

  def create
    @category = current_user.categories.new(category_params_permit)
    if @category.save
      redirect_to redirect_path, notice: 'Category was successfully created.'
    else
      flash[:error] = @category.errors.full_messages.join
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params_permit)
      redirect_to redirect_path, notice: 'Category was successfully updated.'
    else
      flash[:error] = @category.errors.full_messages.join
      render :edit
    end
  end

  def destroy
    if @category.reports.present?
      flash[:error] = 'It has reports so it can not be deleted'
    else
      flash[:notice] = 'Category was successfully deleted.'
      @category.destroy
    end
    redirect_to redirect_path
  end

  private

  def category_params_permit
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def redirect_path
    session[:welcome_categorization] == true ? welcome_categorization_users_path : categories_path
  end

end
