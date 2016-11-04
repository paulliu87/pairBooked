class Student < ApplicationRecord
  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email

  def self.create_with_omniauth(omniauth_hash)
    create! do |student|
      student.username = omniauth_hash["uid"]
      student.fullname = omniauth_hash["name"]
      student.email = omniauth_hash["email"]
    end
  end
end
