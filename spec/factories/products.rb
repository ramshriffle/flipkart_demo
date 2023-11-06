# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    title { 'Mens Casual Premium Slim Fit T-Shirts' }
    description { 'lim-fitting style, contrast raglan long sleeve' }
    category { "men's clothing" }
    price { 100 }
    quantity { 50 }
    rating { Faker::Number.between(from: 1, to: 5) }
    user_id { FactoryBot.create(:user, type: 'Vendor').id }
  end
end
