# Phase-0 challenges
challenge1 = Challenge.create(name: "2.2 Links, Images, and Layouts", due_date: DateTime.new(2016,10,12,12,00,00).beginning_of_hour);
challenge2 = Challenge.create(name: "2.4 Forms", due_date: DateTime.new(2016,10,15,12,00,00).beginning_of_hour);
challenge3 = Challenge.create(name: "3.2 Link Tag", due_date: DateTime.new(2016,10,20,12,00,00).beginning_of_hour);
challenge4 = Challenge.create(name: "3.4 Response Design", due_date: DateTime.new(2016,10,24,12,00,00).beginning_of_hour);
challenge5 = Challenge.create(name: "4.3 Data Type", due_date: DateTime.new(2016,11,02,12,00,00).beginning_of_hour);
challenge6 = Challenge.create(name: "4.6 More Methods", due_date: DateTime.new(2016,11,03,12,00,00).beginning_of_hour);
challenge7 = Challenge.create(name: "5.2 Arrays", due_date: DateTime.new(2016,11,04,12,00,00).beginning_of_hour);
challenge8 = Challenge.create(name: "5.4 Iterations", due_date: DateTime.new(2016,11,05,12,00,00).beginning_of_hour);
challenge9 = Challenge.create(name: "6.2 Instance Methods", due_date: DateTime.new(2016,11,06,12,00,00).beginning_of_hour);
challenge10 = Challenge.create(name: "6.6 Rspec", due_date: DateTime.new(2016,11,07,12,00,00).beginning_of_hour);
challenge11 = Challenge.create(name: "7.2 Data Structure", due_date: DateTime.new(2016,11,12,12,00,00).beginning_of_hour);
challenge12 = Challenge.create(name: "8.2 One to Many", due_date: DateTime.new(2016,11,16,12,00,00).beginning_of_hour);
challenge13 = Challenge.create(name: "8.4 Many to Many", due_date: DateTime.new(2016,11,25,12,00,00).beginning_of_hour);
FactoryGirl.create(:timeslot, challenge_id: challenge1.id, start_at: Time.now.beginning_of_hour + 1.hour, end_at: Time.now.beginning_of_hour + 2.hours)
FactoryGirl.create(:timeslot, challenge_id: challenge1.id, start_at: Time.now.beginning_of_hour + 4.hour, end_at: Time.now.beginning_of_hour + 5.hours)
FactoryGirl.create(:timeslot, challenge_id: challenge1.id, start_at: Time.now.beginning_of_hour + 6.hour, end_at: Time.now.beginning_of_hour + 7.hours)

