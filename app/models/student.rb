class Student < ApplicationRecord
  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email

  def self.create_with_omniauth(auth)
    create! do |student|
      student.username = auth["uid"]
      student.fullname = auth["name"]
      student.email = auth["email"]
    end
  end
end
