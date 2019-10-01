FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    year { Faker::Date.backward(days: 36_500).year.to_s }
    isbn { Faker::Code.isbn }
    association :author
    association :user
  end
end
