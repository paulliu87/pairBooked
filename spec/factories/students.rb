FactoryGirl.define do
  factory :student do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    fullname { Faker::Name.name }
  end
end
