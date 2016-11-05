FactoryGirl.define do
  factory :challenge do
    name {"1.3 Ruby"}
    due_date {Time.now + 7.days}
  end
end
