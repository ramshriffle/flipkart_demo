# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    quantity { 10 }
    # price { 50 }
    product
    address
    user_id { address.user.id }
  end
end
