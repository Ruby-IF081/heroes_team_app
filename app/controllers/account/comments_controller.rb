class Account::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable

  def create
    @comment = @commentable.comments.new(comment_params)
    # @comment = current_user.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      # render :partial => "account/comments/comment",
      #        :locals => { :comment => @comment, company: @commentable, page: nil },
      #        :layout => false, :status => :created
      render partial: 'account/comments/comment', collection: @commentable.comments.reсent, as: :comment,
             locals: { company: @commentable, page: nil }, :layout => false, :status => :created
    else
      render js: "alert('Invalid comment!');"
    end
  end

  def destroy
    @comment = resource
    if @comment.destroy
      render json: @comment, status: :ok
    else
      render js: "alert('error deleting comment');"
    end
  end

  private

  def resource
    Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:user_id, :body, :commentable_type, :commentable_id)
  end

  def find_commentable
    company_id = params[:company_id]
    page_id = params[:page_id]
    find_company = current_companies.find_by_id(company_id)
    @commentable = find_company if company_id
    @commentable = find_company.pages.find_by_id(page_id) if page_id
  end
end
