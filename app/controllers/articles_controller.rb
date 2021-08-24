class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id]) #this instance variavle available in articles#show view
  end

  def new
    @article = Article.new
  end

  def create
    # render plain: params[:article] # shows {"title"=>"zghf", "description"=>"zdghxd"}
    @article = Article.new(params.require(:article).permit(:title, :description))
    # render plain: @article # shows #<Article:0x00007f9460106908> // @article.inspect
    if @article.save 
      flash[:notice] = "Article Created Successfully"
      redirect_to article_path(@article) #redirecting to articles#show view with @article.id
      # redirect_to @article # this is shorthand code for above
    else
      render new_article_path # or 'new'
    end
  end

  def edit
    @article= Article.find(params[:id])
  end

  def update
    @article= Article.find(params[:id])
    if @article.update(params.require(:article).permit(:title,:description))
      flash[:notice] = "Article Updated Successfully"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
    
  end
end