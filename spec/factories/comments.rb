FactoryBot.define do
  factory :comment do
    commentable_type "MyString"
    commentable_id 1
    user_id 1
    body "MyText"
  end
end
