class CategoriesController < ApplicationController
before_action :require_admin, except: [:index, :show]
before_action :set_category, only: [:show, :edit, :update]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 3)
  end
  def new
    @category = Category.new
  end
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category was successfully created"
      redirect_to @category
    else
      render "new"
    end
  end

  def show
    @articles = @category.articles.paginate(page: params[:page], per_page:2)
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category updated successfully!"
      redirect_to category_path(@category)
    else
      render "edit"
    end
  end

  private
  def set_category
    @category = Category.find(params[:id])
  end
  def category_params
    params.require(:category).permit(:name)
  end
  def require_admin
    if !(logged_in? && curr_user.admin?)
      flash[:alert] = "You are not authorized to continue"
      redirect_to categories_path
    end
  end
end