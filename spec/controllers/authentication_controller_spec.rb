require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do

  before(:each) do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
  end

  describe "#login" do

    it "should successfully login a new student" do
      expect {
        post :login, params: {provider: :github}
      }.to change{ Student.count }.by(1)
    end

    it "should successfully login a session" do
      expect(session[:student_id]).to be_nil
      post :login, params: {provider: :github}
      expect(session[:student_id]).to_not be_nil
    end

    it "redirects the student to the challenges url" do
      post :login, params: {provider: :github}
      expect(response).to redirect_to challenges_path
    end

  end

  describe "#logout" do
    before do
      @request.session[:student_id] = FactoryGirl.create(:student).id
      post :login, params: {provider: :github}
    end

    it "should clear the session" do
      expect(session[:student_id]).to_not be_nil
      delete :logout
      expect(session[:student_id]).to be_nil
    end

    it "should redirect to the home page" do
      delete :logout
      expect(response).to redirect_to root_url
    end
  end

  describe "#dashboard" do
    let!(:student) {FactoryGirl.create(:student)}
    let(:acceptor) { Student.find(student.id) }
    let(:initiator) { FactoryGirl.create(:student) }
    let!(:paired_timeslot) {
      timeslot = FactoryGirl.create(:timeslot)
      timeslot.update_attributes(acceptor: acceptor, initiator: initiator)
      timeslot
    }
    let!(:unpaired_timeslot) {
      timeslot = FactoryGirl.create(:timeslot)
      timeslot.update_attributes(acceptor: nil, initiator: Student.find(student.id))
      timeslot
    }

    before(:each) do
      @request.session[:student_id] = student.id
      get :dashboard
    end

    it "knows which timeslots you're paired in" do
      # paired_timeslot

      expect(assigns(:paired_timeslots)).to include(paired_timeslot)
    end

    it "knows your empty timeslots" do
      # unpaired_timeslot
      expect(assigns(:unpaired_timeslots)).to include(unpaired_timeslot)
    end
  end

  describe 'timezone' do
    before do
      @request.session[:student_id] = FactoryGirl.create(:student).id
      post :timezone, params: {timezone: {time_zone: "Central Time (US & Canada)"}}
    end

    it "changes the student timezone" do
      expect(Student.find_by_id(@request.session[:student_id]).time_zone).to eq("Central Time (US & Canada)")
    end
  end

  describe 'slack_name' do

    let(:slacker) {FactoryGirl.create(:student)}

    it 'sets the current students slack name if they have none' do
      @request.session[:student_id] = slacker.id
      post :slack_name, params: {
        slackname:
          {slack_name: "RipWinkle"}
      }
      expect(slacker.slack_name).to eq("RipWinkle")
    end

    it 'updates the current students slack name if they have one' do
      slacker.slack_name = "sleepyhead"
      slacker.save
      @request.session[:student_id] = slacker.id
      post :slack_name, params: {
        slackname:
          {slack_name: "RipWinkle"}
      }
      expect(slacker.slack_name).to eq("RipWinkle")
    end

  end

end
