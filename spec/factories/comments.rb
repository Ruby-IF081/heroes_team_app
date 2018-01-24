FactoryBot.define do
  factory :comment, class: Comment do
    association :commentable, factory: :company
    association :user, factory: :user
    body { Faker::Lorem.paragraphs(1).join }
  end
end
