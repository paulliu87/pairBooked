class Student < ApplicationRecord
  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email
  has_many :timeslots

  def self.create_with_omniauth(omniauth_hash)
    create!({
      username: omniauth_hash["info"]["nickname"],
      fullname: omniauth_hash["info"]["name"],
      email: omniauth_hash["info"]["email"]
    })
  end
end
