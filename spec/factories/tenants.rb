FactoryBot.define do
  factory :tenant, class: Tenant do
    sequence(:name) { |n| "Company #{n}" }
    phone { Faker::PhoneNumber }
    website { Faker::Internet.unique.domain_name }
    logo { Faker::Company.logo }
  end
end
