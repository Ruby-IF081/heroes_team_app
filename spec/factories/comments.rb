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

FactoryBot.define do
  factory :comment, class: Comment do
    association :commentable, factory: :company
    body { Faker::Lorem.paragraphs(1).join }
    after(:build) do |comment|
      user = comment.commentable.user
      comment.user_id = user.id
      comment.tenant_id = user.tenant_id
    end
  end
end
