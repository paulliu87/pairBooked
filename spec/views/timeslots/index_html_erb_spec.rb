require 'rails_helper'

RSpec.describe "challenges/1/timeslots/index.html.erb", type: :view do
  describe "students can see a list of timeslots" do
    let!(:timeslot1) { FactoryGirl.create(:timeslot) }
    let!(:timeslot2) { FactoryGirl.create(:timeslot) }
    let!(:timeslot3) { FactoryGirl.create(:timeslot) }

    before(:each) do
      @timeslots = Timeslot.all
      @challenge = timeslot1.challenge
      render :template => "/timeslots/index.html.erb"
    end

    it "displays list" do
      rendered.should match(/Create/)
      p @timeslots
      rendered.should match(Regexp.new timeslot1.start_at.to_s)
      rendered.should match(Regexp.new timeslot2.start_at.to_s)
    end
  end
end
