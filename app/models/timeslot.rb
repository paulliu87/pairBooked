class Timeslot < ApplicationRecord
  belongs_to :challenge
  belongs_to :initiator, class_name: :Student, foreign_key: :initiator_id
  belongs_to :acceptor, class_name: :Student, foreign_key: :acceptor_id, required: false

  validates_presence_of :initiator_id, :challenge_id, :start_at, :end_at

  def time_zone
    self.initiator.time_zone
  end
end
