# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    address
    user_id { address.user.id }
  end
end
