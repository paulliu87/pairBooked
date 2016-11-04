FactoryGirl.define do
  factory :student do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
  end
end
