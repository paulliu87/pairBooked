require 'rails_helper'

RSpec.feature "UserLogin", type: :feature do
  scenario "User visits login page" do
    visit "/"

    click_link "Login"

    expect(page).to have_text("Github")
  end
end
