require 'rails_helper'

RSpec.describe TimeslotsController, type: :controller do
  describe 'index' do
    let(:timeslot) {FactoryGirl.create(:timeslot)}

    it 'assigns timeslots' do
      get :index, challenge_id: timeslot.challenge_id
      expect(assigns(:timeslots)).to be_a(Hash)
    end

    it 'assigns challenge' do
      get :index, challenge_id: timeslot.challenge_id
      expect(assigns(:challenge)).to be_a Challenge
    end
  end

  # pending 'show' do
  # end

  # pending 'edit' do
  # end

  # pending 'update' do
  # end

  # pending 'destroy' do
  # end

  # pending 'new' do
  # end

  # pending 'create' do
  # end

  describe 'get_timeslot' do
    before(:each) do
      challenge = FactoryGirl.create(:challenge)
      FactoryGirl.create_list(:timeslot, 50, challenge_id: challenge.id)
      get :index, challenge_id: Challenge.first.id
    end

    it "returns a hash containing timeslots" do
      expect(assigns(:timeslots)).to include(:Monday)
      expect(assigns(:timeslots)).to include(:Tuesday)
      expect(assigns(:timeslots)).to include(:Wednesday)
      expect(assigns(:timeslots)).to include(:Thursday)
    end


  end
end
