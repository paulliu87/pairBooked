FactoryGirl.define do
  factory :challenge do
    name {"1.3 Ruby"}
    due_date {Time.now.beginning_of_hour + 7.days}
  end
end
