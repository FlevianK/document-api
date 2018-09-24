50.times do
  document = Document.create(title: Faker::Lorem.word, content: Faker::Lorem.word, created_by: User.first.id)
  document.reviews.create(comment: Faker::Lorem.word)
end
