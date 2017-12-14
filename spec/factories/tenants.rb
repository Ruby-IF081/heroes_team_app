FactoryBot.define do
  factory :tenant, class: Tenant do
    sequence(:name) { |n| "Company #{n}" }
    phone { Faker::PhoneNumber.cell_phone }
    website { Faker::Internet.unique.domain_name }
    logo { Faker::Company.logo }
  end
end
