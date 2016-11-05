require 'rails_helper'

RSpec.describe "challenges/1/timeslots/index.html.erb", type: :view do
  describe "students can see a list of timeslots" do
    let!(:timeslot1) { FactoryGirl.create(:timeslot) }
    let!(:timeslot2) { FactoryGirl.create(:timeslot) }
    let!(:timeslot3) { FactoryGirl.create(:timeslot) }

    before(:each) do
      @timeslots = {
        Monday: Timeslot.all,
        Tuesday: Timeslot.all,
        Wednesday: Timeslot.all,
        Thursday: Timeslot.all,
        Friday: Timeslot.all,
        Saturday: Timeslot.all,
        Sunday: Timeslot.all
      }
      @challenge = timeslot1.challenge
      render :template => "/timeslots/index.html.erb"
    end

    it "displays list" do
      rendered.should match(/Create/)
      rendered.should match(Regexp.new timeslot1.start_at.strftime("%l:%M %P"))
      rendered.should match(Regexp.new timeslot2.start_at.strftime("%l:%M %P"))
    end
  end
end
