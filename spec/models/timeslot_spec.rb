require 'rails_helper'

RSpec.describe Timeslot, type: :model do
  let(:timeslot) { FactoryGirl.build(:timeslot) }
  let(:no_initiator_id_timeslot) { FactoryGirl.build(:timeslot, :no_initiator_id) }
  let(:no_challenge_id_timeslot) { FactoryGirl.build(:timeslot, :no_challenge_id) }
  let(:challenge) {FactoryGirl.build(:challenge)}

  describe "validations" do
    it "allows if valid" do
      expect(timeslot.save).to be true
    end

    it "does not allow without initiator_id " do
      expect(no_initiator_id_timeslot.save).to be false
    end

    it "does not allow without initiator_id " do
      expect(no_challenge_id_timeslot.save).to be false
    end

    it "does not allow without start_at " do
      timeslot.start_at = nil
      expect(timeslot.save).to be false
    end

    it "does not allow without end_at " do
      timeslot.end_at = nil
      expect(timeslot.save).to be false
    end

    it "does not create a new timeslot" do
      slot = FactoryGirl.build(:timeslot)
      slot.start_at=  100.hours.ago
      slot.end_at=  99.hours.ago
      expect(slot.save).to be false
    end

    it "does not allow the timeslot is partially overlap the exited ones" do
      timeslot.save
      slot = FactoryGirl.build(:timeslot)
      slot.start_at=  100.hours.ago

    end

    it "does not allow the timeslot is fully overlap the exited ones" do

    end
  end

  describe "associations" do
    it "belongs to a challenge" do
      expect(timeslot.challenge).to be_a (Challenge)
    end

    it "belongs to an initiator" do
      expect(timeslot.initiator).to be_a (Student)
    end

    it "belongs to an acceptor" do
      timeslot.acceptor = FactoryGirl.build_stubbed(:student)
      expect(timeslot.acceptor).to be_a (Student)
    end
  end

end
