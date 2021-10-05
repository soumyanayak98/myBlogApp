class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    if @comment.save
      flash[:notice]="Comment added successfully"
      redirect_to @article
    else
      flash[:error] = "Comment not added"
      redirect_to @article
    end
  end
  
  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:name, :body)
    end
end
