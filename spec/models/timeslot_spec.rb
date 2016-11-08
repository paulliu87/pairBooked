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

  end

  describe "associations" do
    it "belongs to a challenge" do
      expect(timeslot.challenge).to be_a (Challenge)
    end

    it "belongs to an initiator" do
      expect(timeslot.initiator).to be_a (Student)
    end

    it "can update timezone through the initiator" do
      timeslot.initiator.update_attribute(
        :time_zone, "Eastern Time (US & Canada)"
      )
      expect(timeslot.time_zone).to eq("Eastern Time (US & Canada)")
    end

    it "belongs to an acceptor" do
      timeslot.acceptor = FactoryGirl.build_stubbed(:student)
      expect(timeslot.acceptor).to be_a (Student)
    end
  end

end
