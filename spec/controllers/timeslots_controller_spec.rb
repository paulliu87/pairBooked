require 'rails_helper'

RSpec.describe TimeslotsController, type: :controller do
  describe 'index' do
    it 'assigns timeslots' do
      get :"/categories/1/timeslots"
      expect(@timeslots).to all(be(Timeslot))
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
