FactoryBot.define do
  factory :document do
    title { Faker::Lorem.word }
    content { Faker::Lorem.word }
    created_by { Faker::Number.number(10) }
  end
end