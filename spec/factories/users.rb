FactoryBot.define do
  factory :user do
    name { Faker.name}
    username { Faker::Internet.unique.user_name }
    email { Faker::Internet.unique.email(name: name) }
    password { Faker::Internet.password(min_length: 6, mix_case: true, special_characters: true) }
    password_confirmation { password }
    type { "Customer" }
    sequence(:mobile_no) {|n| "900958245"+ "#{n}"}
  end
end
