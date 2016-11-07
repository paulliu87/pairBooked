require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do

  before(:each) do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
  end

  describe "#login" do

    it "should successfully login a new student" do
      expect {
        post :login, provider: :github
      }.to change{ Student.count }.by(1)
    end

    it "should successfully login a session" do
      session[:student_id].should be_nil
      post :login, provider: :github
      session[:student_id].should_not be_nil
    end

    it "should redirect the student to the challenges url" do
      post :login, provider: :github
      response.should redirect_to challenges_path
    end

  end

  describe "#logout" do
    before do
      @request.session[:student_id] = FactoryGirl.create(:student).id
      post :login, provider: :github
    end

    it "should clear the session" do
      session[:student_id].should_not be_nil
      delete :logout
      session[:student_id].should be_nil
    end

    it "should redirect to the home page" do
      delete :logout
      response.should redirect_to root_url
    end
  end

  describe '#timezone' do
    before do
      @request.session[:student_id] = FactoryGirl.create(:student).id
      post :timezone, {timezone_id: 3}
    end

    it 'changes the timezone for the student' do
      expect(Student.find(session[:student_id]).time_zone).to eq("Eastern Time (US & Canada)")
    end
  end
end
