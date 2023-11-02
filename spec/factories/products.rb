FactoryBot.define do
  factory :product do
    title { Faker::Hipster.sentences}
    description { Faker::Hipster.sentences }
    category { Faker::Hipster.sentences}
    price { 100 }
    quantity { 50 }
    rating { Faker::Number.between(from: 1, to: 5)}
    # image  { Faker::LoremFlickr.image }
    user_id { FactoryBot.create(:user, type: "Vendor").id }
  end
end
