require "rails_helper"
RSpec.feature "students can see form that creates a new timeslot" do
  context "when students visit the timeslots create page" do
    let!(:challenge)  {FactoryGirl.create(:challenge)}
    let!(:timeslot)   {FactoryGirl.create(:timeslot)}
    given!(:student) { FactoryGirl.create(:student) }
    scenario "students can fill the form and create a new timeslot" do
      page.set_rack_session(student_id: student.id)
      visit "/challenges/#{challenge.id}/timeslots/new"
      fill_in 'example-date-input', :with => '2016-11-16'
      fill_in "example-time-start-input", :with => '10:30'
      fill_in "example-time-end-input", :with => '11:30'
      click_button 'Submit'
      expect(page.current_path).to eq("/challenges/#{challenge.id}/timeslots")
    end
  end
end
