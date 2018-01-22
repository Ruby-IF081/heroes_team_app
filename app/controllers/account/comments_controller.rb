class Account::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.js   {}
      end
    else
      render js: "alert('Your comment is too short!');"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_commentable
    find_company = current_companies.find_by_id(params[:company_id])
    @commentable = find_company if params[:company_id]
    @commentable = find_company.pages.find_by_id(params[:page_id]) if params[:page_id]
  end
end
