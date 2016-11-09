require "rails_helper"
RSpec.feature "students can see form that creates a new timeslot" do
  context "when students visit the timeslots create page" do
    let!(:challenge)  {FactoryGirl.create(:challenge)}
    let!(:timeslot)   {FactoryGirl.create(:timeslot)}
    given!(:student) { FactoryGirl.create(:student) }
    scenario "students can fill the form and create a new timeslot" do
      page.set_rack_session(student_id: student.id)
      visit "/challenges/#{challenge.id}/timeslots/new"
      fill_in 'timeslot-date-input', :with => '2016-11-16'
      find_field('timeslot-time-start-input').find(:xpath, 'option[2]').select_option
      find_field('timeslot-time-end-input').find(:xpath, 'option[3]').select_option
      click_button 'Submit'
      expect(page.current_path).to eq("/challenges/#{challenge.id}/timeslots")
    end
  end
end
