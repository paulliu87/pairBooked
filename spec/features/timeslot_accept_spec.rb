require "rails_helper"
RSpec.feature "student accept timeslot" do
  context "when student accept a timeslot" do
    let!(:challenge) { Challenge.create( name: "2.2 Links, Images, and Layouts", due_date: DateTime.new(2016,10,12,12,00,00)) }
    let!(:timeslot) { FactoryGirl.create( :timeslot, challenge_id: challenge.id) }
    let!(:empty_timeslot) { FactoryGirl.create( :timeslot, challenge_id: challenge.id, start_at: timeslot.end_at + 1.hour, end_at: timeslot.end_at + 2.hour) }
    given!(:student) { FactoryGirl.create(:student) }
    scenario "student will be registered" do
      page.set_rack_session(student_id: student.id)
      visit "/challenges/#{challenge.id}/timeslots/#{timeslot.id}"
      find_button("Book!").click
      expect(page.current_path).to eq("/challenges/#{challenge.id}/timeslots/#{timeslot.id}")
    end
    scenario "All empty timeslots will be removed" do
      page.set_rack_session(student_id: student.id)
      visit "/challenges/#{challenge.id}/timeslots/#{timeslot.id}"
      removed_id = empty_timeslot.id
      find_button("Book!").click
      expect(Timeslot.find(removed_id)).to eq(nil)
    end
  end
end
