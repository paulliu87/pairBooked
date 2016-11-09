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

    it 'does allow acceptor to be the initiator' do
      timeslot.acceptor = timeslot.initiator
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

  describe 'future_and_other_person?' do
    let(:other_student) { FactoryGirl.create(:student) }
    let(:past_timeslot) {
      timeslot = FactoryGirl.create(:timeslot)
      timeslot.initiator = other_student
      timeslot.start_at = 3.days.ago.beginning_of_hour
      timeslot.save(validate: false)
      timeslot
    }
    before do
      allow(timeslot).to receive(:current_student) {other_student}
      allow(past_timeslot).to receive(:current_student) {other_student}
    end

    it 'returns true if timeslot is future and other student' do
      expect(timeslot.future_and_other_person?).to be true
    end

    it 'returns false if timeslot is past' do
      expect(past_timeslot.future_and_other_person?).to be false
    end

    it 'returns false if timeslot belongs to current_student' do
      timeslot.initiator = other_student
      expect(timeslot.future_and_other_person?).to be false
    end
  end


end
