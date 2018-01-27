require 'rails_helper'

RSpec.describe Account::CommentsController, type: :controller do
  before :each do
    @user = FactoryBot.create(:user, :admin)
    sign_in @user
  end
  describe 'POST create' do
    render_views
    context 'with valid attributes' do
      let!(:val_comment) { build :comment }
      it 'should create a new comment' do
        expect do
          post :create, xhr: true, params: { comment:
                                           { commentable_type: val_comment.commentable_type,
                                             commentable_id: val_comment.commentable_id,
                                             user_id: val_comment.user_id,
                                             body: val_comment.body } }
        end.to change(Comment, :count).by(1)
      end
    end
    context 'with invalid attributes' do
      let!(:invalid_comment) { build :comment }
      it 'should not create a new comment' do
        expect do
          post :create, xhr: true, params: { comment:
                                           { commentable_type: invalid_comment.commentable_type,
                                             commentable_id: invalid_comment.commentable_id,
                                             user_id: invalid_comment.user_id,
                                             body: ' ' } }
        end.to_not change(Comment, :count)
      end
    end
  end
  describe 'DELETE destroy' do
    render_views
    context 'when user has privilege' do
      let!(:comment) { create :comment }
      it 'should delete the comment' do
        expect do
          delete :destroy, xhr: true, params: { id: comment.id }
        end.to change(Comment, :count).by(-1)
      end
    end
    context 'when user has no privilege' do
      before :each do
        @sale = FactoryBot.create(:user, :sale)
        sign_out @user
        sign_in @sale
      end
      let!(:comment) { create :comment }
      it 'should not delete the comment' do
        expect do
          delete :destroy, xhr: true, params: { id: comment.id }
        end.to_not change(Comment, :count)
      end
    end
  end
end
