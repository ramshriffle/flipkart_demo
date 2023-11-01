FactoryBot.define do
  factory :user do
    name { Faker::Internet.name}
    username { Faker::Internet.unique.user_name }
    email { Faker::Internet.unique.email}
    # mobile_no { Faker::PhoneNumber.mobile_no}
    password { Faker::Internet.password(min_length: 6, mix_case: true, special_characters: true) }
    password_confirmation { password }
    type { 'Customer' }
  end
end
