require "rails_helper"
RSpec.feature "display timeslots list" do
  context "when students visit the timeslots index page" do
    let!(:challenge) { Challenge.create(name: "2.2 Links, Images, and Layouts", due_date: DateTime.new(2016,10,12,12,00,00)) }
    let!(:timeslot) { FactoryGirl.create( :timeslot, challenge_id: challenge.id)}
    given!(:student) { FactoryGirl.create(:student) }
    scenario "students can click on a challenge" do
      page.set_rack_session(student_id: student.id)
      visit "/challenges/#{challenge.id}/timeslots"
      find(".timeslot a").click
      expect(page.current_path).to eq("/challenges/#{challenge.id}/timeslots/#{timeslot.id}")
    end
  end

  context "when challenge does not exist" do
    given!(:student) { FactoryGirl.create(:student) }
    scenario "students can click on a challenge" do
      page.set_rack_session(student_id: student.id)
      visit "/challenges/1/timeslots"
      expect(page.current_path).to eq("/challenges")
    end
  end
end
