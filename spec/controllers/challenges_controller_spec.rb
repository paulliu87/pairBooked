require 'rails_helper'

RSpec.describe ChallengesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "challenges#index" do
    it "goes challenges index page" do
      get :index
      expect(get :index).to render_template :index
    end
  end

end
