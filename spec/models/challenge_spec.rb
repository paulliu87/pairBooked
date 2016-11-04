require 'rails_helper'

RSpec.describe Challenge, type: :model do
  let(:valid_challenge) { Challenge.new(name: "2.2 Links, Images, and Layouts", due_date: DateTime.new(2016,11,25,12,00,00)) }
  let(:invalid_challenge_1) { Challenge.new( due_date: DateTime.new(2016,11,25,12,00,00)) }
  let(:invalid_challenge_2) { Challenge.new(name: "2.2 Links, Images, and Layouts") }

  pending 'associations' do
    before(:each) do
      challenge.save
      challenge.timeslots = time_slots
    end

    it 'has many time slots' do
      expect(valid_challenge.timeslots).to all(be_a Timeslot)
    end
  end

  describe 'validations' do
    it 'allows if valid' do
      expect(valid_challenge.save).to be true
    end

    it 'does not allow if no name' do
      expect(invalid_challenge_1.save).to be false
    end

    it 'does not allow if no due date' do
      expect(invalid_challenge_2.save).to be false
    end

  end
end



