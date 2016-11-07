require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the AuthenticationHelper. For example:
#
# describe AuthenticationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe AuthenticationHelper, type: :helper do
  pending "convert_date" do
    let(:time){DateTime.new(2016,3,14,10,0,0,'-8')}
    before do
      @request.session[:student_id] = FactoryGirl.create(:student).id
      Student.find(session[:student_id]).time_zone = "Eastern Time (US & Canada)"
    end

    it 'puts date in the right timezone' do
      expect(convert_date(time)).to eq("March 14 at 1:00 PM")
    end
  end
end
