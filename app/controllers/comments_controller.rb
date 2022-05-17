class CommentsController < ApplicationController
  def create
    comment = Comment.new(params_comment)
    if comment.save
      redirect_to "/prototypes/#{comment.prototype.id}"
    else
      @prototype = comment.prototype
      @comment = Comment.new
      @comments = @prototype.comment.includes(:user)
      render 'prototypes/show'
    end
  end

  private
  def params_comment
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
