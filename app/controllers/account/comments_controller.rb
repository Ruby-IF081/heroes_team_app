class Account::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      respond_format
    else
      respond_format render js: "alert('Comment is invalid!');"
    end
  end

  def destroy
    @comment = resource
    if current_user.privileged?
      @comment.destroy
      respond_format
    else
      respond_format render js: "alert('No rights to delete this comment');"
    end
  end

  private

  def respond_format(block = nil)
    respond_to { |format| format.js { block } }
  end

  def resource
    Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id)
  end
end
