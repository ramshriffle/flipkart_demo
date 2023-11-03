# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker.name }
    username { Faker::Internet.unique.user_name }
    email { Faker::Internet.unique.email(domain: 'gmail.com') }
    password { Faker::Internet.password(min_length: 6, mix_case: true, special_characters: true) }
    password_confirmation { password }
    type { 'Customer' }
    sequence(:mobile_no) { |n| "900958245#{n}" }
    otp { SecureRandom.hex(3) }
    otp_sent_at { Time.now.utc }
  end
end
