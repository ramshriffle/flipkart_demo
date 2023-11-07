# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker.name }
    username { Faker::Internet.unique.user_name }
    email { Faker::Internet.unique.email(domain: 'gmail.com') }
    password { Faker::Internet.password(min_length: 6, mix_case: true, special_characters: true) }
    password_confirmation { password }
    type { 'Customer' }
    mobile_no { Faker::PhoneNumber.cell_phone_with_country_code }
  end
end
