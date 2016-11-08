class Student < ApplicationRecord
  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email
  has_many :accepted_timeslots, class_name: :Timeslot, foreign_key: :acceptor_id
  has_many :initiated_timeslots, class_name: :Timeslot, foreign_key: :initiator_id

  def self.create_with_omniauth(omniauth_hash)
    create!({
      username: omniauth_hash["info"]["nickname"],
      fullname: omniauth_hash["info"]["name"],
      email: omniauth_hash["info"]["email"]
    })
  end

end
