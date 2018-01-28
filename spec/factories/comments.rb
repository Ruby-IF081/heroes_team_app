FactoryBot.define do
  factory :comment, class: Comment do
    association :commentable, factory: :company
    association :user, factory: :user
    tenant_id { create(:user).tenant_id }
    body { Faker::Lorem.paragraphs(1).join }
  end
end
