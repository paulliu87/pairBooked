class Student < ApplicationRecord
  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email
  has_many :timeslots

  def self.create_with_omniauth(omniauth_hash)
    create! do |student|
      student.username = omniauth_hash["info"]["nickname"]
      student.fullname = omniauth_hash["info"]["name"]
      student.email = omniauth_hash["info"]["email"]
    end
  end
end
