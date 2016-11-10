require "rails_helper"
RSpec.feature "student accept timeslot" do
  context "when student accept a timeslot" do
    let(:creator) { FactoryGirl.create(:student) }
    given!(:student) { FactoryGirl.create(:student) }
    let!(:challenge) { Challenge.create( name: "2.2 Links, Images, and Layouts", due_date: DateTime.new(2016,10,12,12,00,00)) }
    let!(:timeslot) { FactoryGirl.create( :timeslot, challenge_id: challenge.id, initiator_id: creator.id ) }
    let!(:empty_timeslot) { FactoryGirl.create( :timeslot, challenge_id: challenge.id, start_at: timeslot.end_at + 1.hour, end_at: timeslot.end_at + 2.hour, initiator_id: creator.id) }
    scenario "student will be registered" do
      page.set_rack_session(student_id: student.id)
      visit "/challenges/#{challenge.id}/timeslots/#{timeslot.id}"
      page.find("#book-button").click
      expect(page.current_path).to eq("/challenges/#{challenge.id}/timeslots/#{timeslot.id}")
    end
    scenario "All empty timeslots will be removed" do
      page.set_rack_session(student_id: student.id)
      visit "/challenges/#{challenge.id}/timeslots/#{timeslot.id}"
      removed_id = empty_timeslot.id
      page.find("#book-button").click
      expect(Timeslot.find_by_id(removed_id)).to eq nil
    end
  end
end
