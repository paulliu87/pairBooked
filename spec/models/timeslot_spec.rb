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

    it 'does not allow end_at before start_at' do
      timeslot.start_at = DateTime.now + 3.hours
      timeslot.end_at = DateTime.now + 2.hours
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

  xdescribe 'scopes' do
    let(:old_slot) {FactoryGirl.build(:timeslot, start_at: Time.zone.now.beginning_of_hour - 3.days)}
    let(:soon_slot) {FactoryGirl.create(:timeslot, start_at: Time.zone.now.beginning_of_hour + 1.hour)}
    let(:future_slot) {FactoryGirl.create(:timeslot, start_at: Time.zone.now.beginning_of_hour + 3.hour)}

    before do
      old_slot.save(validate: false); soon_slot; future_slot
    end

    it 'shows soon scopes' do
      expect(Timeslot.future.soon).to include(soon_slot)
      expect(Timeslot.future.soon).not_to include(future_slot)
      expect(Timeslot.future.soon).not_to include(old_slot)
    end

    it 'shows old scopes' do
      expect(Timeslot.future).to include(future_slot)
      expect(Timeslot.future).to include(soon_slot)
      expect(Timeslot.future).not_to include(old_slot)
    end
  end

end
