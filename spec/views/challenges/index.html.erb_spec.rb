require 'rails_helper'

RSpec.describe "challenges/index.html.erb", type: :view do
  describe "students can see a list of challenges" do
    let!(:challenge1) { Challenge.create(name: "2.2 Links, Images, and Layouts", due_date: DateTime.new(2016,10,12,12,00,00)) }
    let!(:challenge2) { Challenge.create(name: "2.4 Forms", due_date: DateTime.new(2016,10,15,12,00,00)) }
    let!(:challenge3) { Challenge.create(name: "3.2 Link Tag", due_date: DateTime.new(2016,10,20,12,00,00)); }

    before(:each) do
      @challenges = Challenge.all
      render :template => "challenges/index.html.erb"
    end

    it "displays list" do
      rendered.should match(/2.2 Links, Images, and Layouts/)
      rendered.should match(/2.4 Forms/)
      rendered.should match(/3.2 Link Tag/)
    end
  end
end
