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
      timeslot }

    before(:each) do
      @student = student
      timeslot1
      timeslot2
      @unpaired_timeslots = Timeslot.where(initiator: @student, acceptor: nil)
      @request.session[:student_id] = student.id
      render :template => "authentication/dashboard"
    end

    it "displays list" do
      rendered.should match(Regexp.new "10:00 am on Thursday, November 10")
      rendered.should match(Regexp.new "10:00 am on Wednesday, November 16")
    end
  end
end
