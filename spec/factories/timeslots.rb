FactoryGirl.define do
  factory :timeslot do
    initiator_id {FactoryGirl.create(:student).id}
    start_at {Time.now.beginning_of_hour + 4.days + rand(168).floor.hours}
    end_at {start_at + 1.hours}
    challenge_id {FactoryGirl.create(:challenge).id}

    trait :no_initiator_id do
      initiator_id nil
    end

    trait :no_challenge_id do
      challenge_id nil
    end

    trait :old_start_at_date do
      start_at DateTime.now.days_ago(1).beginning_of_hour
    end

    trait :monday do
      start_at {
        date = Date.today
        date += 1 + ((3-date.wday) % 7) + 7.days
      }
      end_at {
       date = Date.today
       date += 1 + ((3-date.wday) % 7) + 7.days + 1.hour
      }
    end

  end
end
