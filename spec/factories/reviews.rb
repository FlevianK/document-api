FactoryBot.define do
  factory :review do
    comment { Faker::Lorem.word }
    document_id nil
  end
end