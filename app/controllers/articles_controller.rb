class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  # run set_article before each action

  def index
    @articles = Article.all
  end

  def show
    # @article = Article.find(params[:id]) this instance variavle available in articles#show view
  end

  def new
    @article = Article.new
  end

  def create
    # render plain: params[:article] # shows {"title"=>"zghf", "description"=>"zdghxd"}
    @article = Article.new(article_params)
    @article.user = User.first
    # render plain: @article # shows #<Article:0x00007f9460106908> // @article.inspect
    if @article.save 
      flash[:notice] = "Article Created Successfully"
      redirect_to article_path(@article)
      # redirect_to @article # this is shorthand code for above
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

end