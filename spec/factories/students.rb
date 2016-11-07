FactoryGirl.define do
  factory :student do
    sequence(:username) {|n| "user#{n}"}
    sequence(:email) {|n| "user#{n}@example.com"}
    sequence(:fullname) {|n| "User#{n} Lastname"}
  end
end
