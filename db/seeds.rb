30.times do
  Document.create(title: Faker::Lorem.word, content: Faker::Lorem.word, created_by: User.first.id)
end
