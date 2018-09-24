FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email 'kan@flev.com'
    password 'kanflev'
  end
end