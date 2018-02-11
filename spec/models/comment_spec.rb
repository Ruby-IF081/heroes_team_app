# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commentable_type :string
#  commentable_id   :integer
#  user_id          :integer
#  body             :text
#  tenant_id        :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:comment) { create(:comment) }
  it 'has a valid factory' do
    expect(comment).to be_valid
    expect(comment.tenant). to eq(comment.user.tenant)
  end
end
