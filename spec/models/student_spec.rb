require 'rails_helper'

RSpec.describe Student, type: :model do

  let(:student) {Student.new(
    username: "sleepyhead",
    fullname: "Rip van Winkle",
    email: "sleepyheadzzz@gmail.com",
    slack_name: "rvwinkle"
    )}

  describe "validations" do
    it "saves with valid information" do
      expect(student.save).to be true
    end

    it "saves without a slackname" do
      student.slack_name = nil
      expect(student.save).to be true
    end

    it "does not allow without username" do
      student.username = nil
      expect(student.save).to be false
    end

    it "does not allow without email" do
      student.email = nil
      expect(student.save).to be false
    end
  end

  describe "create_with_omniauth" do
    let(:omniauth_hash) { OmniAuth.config.mock_auth[:github] }
    let(:omniauth_student) { Student.create_with_omniauth(omniauth_hash) }

    it "has a username" do
      expect(omniauth_student.username).to eq("SunjayH")
    end
  end
end
