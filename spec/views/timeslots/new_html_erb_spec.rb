require 'rails_helper'

RSpec.describe "challenges/1/timeslots/new.html.erb", type: :view do
  xdescribe "students can see a form that creates a new page" do
    let!(:challenge) { FactoryGirl.create(:challenge) }

    before(:each) do
      assign(:challenge, [
        stub_model(Challenge,
          name: "2.2 Links, Images, and Layouts",
          due_date: DateTime.new(2016,10,12,12,00,00)
        ),
      ])
      render :template => "timeslots/new.html.erb"
    end

    it "displays form" do
      rendered.should contain('Start date')
      rendered.should contain('Start time')
      rendered.should contain('End time')
    end
  end
end
