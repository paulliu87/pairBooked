require "rails_helper"
RSpec.feature "students can see challenges list" do
  context "when students visit the challenge index page" do
    let!(:challenge1) { Challenge.create(name: "2.2 Links, Images, and Layouts", due_date: DateTime.new(2016,10,12,12,00,00)) }
    let(:challenge2) { Challenge.create(name: "2.4 Forms", due_date: DateTime.new(2016,10,15,12,00,00)) }
    let(:challenge3) { Challenge.create(name: "3.2 Link Tag", due_date: DateTime.new(2016,10,20,12,00,00)); }

    scenario "students can click on a challenge" do
      visit '/challenges'

      click_link '2.2 Links, Images, and Layouts'
      expect(page).to redirect_to("/challenges/#{challenge1.id}/timeslots")
    end
  end
end
