require "rails_helper"
RSpec.feature "require_login" do
  context "when student are not login" do
    scenario "student will be redirect back to login page" do
      visit '/challenges'
      expect(page.current_path).to eq("/")
    end
  end
end
