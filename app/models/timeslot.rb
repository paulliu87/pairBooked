class Timeslot < ApplicationRecord
  belongs_to :challenge
  belongs_to :initiator, class_name: :Student, foreign_key: :initiator_id
  belongs_to :acceptor, class_name: :Student, foreign_key: :acceptor_id, required: false

  validates_presence_of :initiator_id, :challenge_id, :start_at, :end_at
  validate :date, :check_duplicate_timeslot

  def date
    if start_at && end_at
      if start_at.to_date < DateTime.now.to_date
        errors.add(:start_date, "must be after #{DateTime.now.to_date}.")
      elsif (start_at.to_date == DateTime.now.to_date) && (start_at.strftime('%F%H:%M') < DateTime.now.strftime('%F%H:%M'))
        current_time = DateTime.now.strftime("%I:%M %p")
        errors.add(:start_time, "must be after #{current_time}.")
      elsif start_at.to_time > end_at.to_time
        errors.add(:start_time, "must be after end time.")
      end
    end
  end

  def check_duplicate_timeslot
    timeslots = Timeslot.where(initiator_id: initiator_id)
    timeslots.each do |timeslot|
      if timeslot.start_at.to_date == start_at.to_date
        if timeslot.start_at.to_time >= start_at.to_time && timeslot.start_at.to_time < end_at.to_time && timeslot.end_at.to_time > end_at.to_time
          errors.add(:end_time, "must be before #{timeslot.start_at.strftime('%H:%M %p')}.")
        elsif timeslot.start_at.to_time <= start_at.to_time && timeslot.end_at.to_time >= end_at.to_time
          errors.add(:start_time, "must be after #{timeslot.end_at.strftime('%H:%M %p')} or end time must be before #{timeslot.start_at.strftime('%H:%M %p')}.")
        elsif timeslot.end_at.to_time > start_at.to_time && timeslot.end_at.to_time <= end_at.to_time && timeslot.start_at.to_time < start_at.to_time
          errors.add(:start_time, "must be after #{timeslot.end_at.strftime('%H:%M %p')}.")
        elsif timeslot.start_at.to_time > start_at.to_time && timeslot.end_at.to_time < end_at.to_time
          errors.add(:end_time, "must be before #{timeslot.start_at.strftime('%H:%M %p')} or start time must be after #{timeslot.end_at.strftime('%H:%M %p')}.")
        end
        break
      end
    end
  end

  def self.clean_up
    self.where( start_at:(Time.now.midnight - 7.days)..Time.now.midnight).each do |timeslot|
      timeslot.destroy
    end
  end
end
