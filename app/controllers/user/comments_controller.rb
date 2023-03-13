class User::CommentsController < ApplicationController

  def create
    illustration = Illustration.find(params[:illustration_id])
    comment = current_account.comments.new(comment_params)
    comment.illustration_id = illustration.id
    comment.save
    redirect_to illustration_path(illustration)
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to illustration_path(params[:illustration_id])
  end
  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
