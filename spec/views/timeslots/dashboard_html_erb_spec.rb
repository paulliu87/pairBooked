require 'rails_helper'

RSpec.describe "challenges/1/timeslots/index.html.erb", type: :view do
  describe "students can see a list of timeslots" do
    let!(:student){
      student = FactoryGirl.create(:student)
      student.time_zone = "Pacific Time (US & Canada)"
      student.save
      student
      }
    let!(:timeslot1) {
      timeslot = FactoryGirl.create(:timeslot)
      timeslot.initiator = student
      timeslot.start_at = DateTime.new(2016,11,10,10,0,0,"-8")
      timeslot.end_at = timeslot.start_at + 1.hour
      timeslot.save
      timeslot
     }
    let!(:timeslot2) {
      timeslot = FactoryGirl.create(:timeslot)
      timeslot.initiator = student
      timeslot.start_at = DateTime.new(2016,11,16,10,0,0,"-8")
      timeslot.end_at = timeslot.start_at + 1.hour
      timeslot.save
      timeslot
    }
    let!(:timeslot3) {
      timeslot = FactoryGirl.create(:timeslot)
      timeslot.acceptor = student
      timeslot.start_at = DateTime.new(2016,11,12,10,0,0,"-8")
      timeslot.end_at = timeslot.start_at + 1.hour
      timeslot.save
      timeslot
     }
    let!(:timeslot4) {
      timeslot = FactoryGirl.create(:timeslot)
      timeslot.acceptor = student
      timeslot.start_at = DateTime.new(2016,11,14,10,0,0,"-8")
      timeslot.end_at = timeslot.start_at + 1.hour
      timeslot.save
      timeslot
    }

    before(:each) do
      @student = student
      @request.session[:student_id] = student.id
      timeslot1
      timeslot2
      timeslot3
      timeslot4
      @paired_timeslots = Timeslot.where(initiator: @student, acceptor: !nil) + @student.accepted_timeslots
      @unpaired_timeslots = Timeslot.where(initiator: @student, acceptor: nil)
      render :template => "authentication/dashboard"
    end

    it "displays unpaired list" do
      rendered.should match(Regexp.new "10:00 am on Thursday, November 10")
      rendered.should match(Regexp.new "10:00 am on Wednesday, November 16")
    end

    it 'displays paired list' do
      rendered.should match(Regexp.new "10:00 am on Saturday, November 12")
      rendered.should match(Regexp.new "10:00 am on Monday, November 14")
    end
  end
end
