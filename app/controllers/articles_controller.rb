class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    # @articles = Article.all
    @articles = Article.paginate(page: params[:page], per_page: 3)
  end

  def show
    # @article = Article.find(params[:id]) this instance variavle available in articles#show view
  end

  def new
    @article = Article.new
  end

  def create
    # render plain: params[:article] # shows {"title"=>"zghf", "description"=>"zdghxd"}
    # render plain: @article # shows #<Article:0x00007f9460106908> // @article.inspect
    @article = Article.new(article_params)
    @article.user = curr_user # a user must be logged in to create a new article
    if @article.save 
      flash[:notice] = "Article Created Successfully"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def edit
    # @article= Article.find(params[:id])
  end

  def update
    # @article= Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article Updated Successfully"
      redirect_to article_path(@article)
    else
      render 'edit'
    end 
  end

  def destroy
    # @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if curr_user != @article.user
      flash[:alert] = "You are not allowed to edit this article"
      redirect_to article_path(@article)
    end
  end

end