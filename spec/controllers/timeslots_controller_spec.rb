require 'rails_helper'

RSpec.describe TimeslotsController, type: :controller do
  describe 'index' do
    let(:timeslot) {FactoryGirl.create(:timeslot)}

    it 'assigns timeslots' do
      get :index, challenge_id: timeslot.id
      expect(assigns(:timeslots)).to all(be_a(Timeslot))
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
end
