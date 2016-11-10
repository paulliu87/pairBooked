require "rails_helper"
RSpec.feature "cleanup database weekly", js: true do
  context "call the method of cleanup" do
    let(:challenge) { Challenge.create(name: "2.2 Links, Images, and Layouts", due_date: DateTime.new(2016,10,12,12,00,00)) }
    let!(:timeslots) {
      50.times do
        t = FactoryGirl.build(:timeslot, challenge_id: challenge.id, start_at: Time.now.beginning_of_hour - 9.days, end_at: Time.now.beginning_of_hour - 8.days)
        t.save(:validate => false)
        t
      end
    }

    scenario "all the empty timeslots will be removed from previous week" do
      Timeslot.clean_up
      expect(Timeslot.count).to eq(0)
    end
  end
end
