class Challenge < ApplicationRecord
  validates_presence_of :due_date, :name
  has_many :timeslots

   def get_timeslots
    timeslots = {}
    all_timeslots = self.timeslots.order("start_at ASC")

    timeslots[:Monday] = all_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Mon" && timeslot.future_and_other_person?
    end

    timeslots[:Tuesday] = all_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Tue" && timeslot.future_and_other_person?
    end

    timeslots[:Wednesday] = all_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Wed" && timeslot.future_and_other_person?
    end

    timeslots[:Thursday] = all_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Thu" && timeslot.future_and_other_person?
    end

    timeslots[:Friday] = all_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Fri" && timeslot.future_and_other_person?
    end

    timeslots[:Saturday] = all_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Sat" && timeslot.future_and_other_person?
    end

    timeslots[:Sunday] = all_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Sun" && timeslot.future_and_other_person?
    end

    #return a hash with keys of days and values of array of time slots
    timeslots
  end


end
