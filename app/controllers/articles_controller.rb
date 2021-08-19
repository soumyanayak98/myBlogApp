class ArticlesController < ApplicationController

  def show
    @article = Article.find(params[:id]) #this instance variavle available in articles#show view
  end
end