# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    street { Faker::Address.street_name }
    city { Faker::Address.city }
    pincode { Faker::Number.number(digits: 6) }
    user
  end
end
