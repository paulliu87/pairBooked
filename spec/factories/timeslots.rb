FactoryGirl.define do
  factory :timeslot do
    initiator_id {FactoryGirl.create(:student).id}
    start_at {Time.now + 4.days}
    end_at {Time.now + 4.days + 2.hours}
    challenge_id {FactoryGirl.create(:challenge).id}

    trait :no_initiator_id do
      initiator_id nil
    end

    trait :no_challenge_id do
      challenge_id nil
    end

    trait :first_challenge_id do
      challenge_id 1
    end

  end
end
