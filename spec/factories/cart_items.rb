# frozen_string_literal: true

FactoryBot.define do
  factory :cart_item do
    quantity { 10 }
    price { 50 }
    product
    cart
  end
end
