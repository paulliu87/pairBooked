class Challenge < ApplicationRecord
  validates_presence_of :due_date, :name
  has_many :timeslots

  def get_soon_timeslots(student)
    timeslots_hash = Hash.new
    day = Time.now.strftime("%A").to_sym
    soon_timeslots = self.timeslots.soon.order("start_at ASC").future.not_mine(student)
    timeslots_hash[day] = soon_timeslots
    timeslots_hash
  end

  def get_not_soon_timeslots(student)
    timeslots_hash = {}
    not_soon_timeslots = self.timeslots.not_soon.order("start_at ASC").future.not_mine(student)

    #Puts in not_soon times
    timeslots_hash[:Monday] = not_soon_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Mon"
    end

    timeslots_hash[:Tuesday] = not_soon_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Tue"
    end

    timeslots_hash[:Wednesday] = not_soon_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Wed"
    end

    timeslots_hash[:Thursday] = not_soon_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Thu"
    end

    timeslots_hash[:Friday] = not_soon_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Fri"
    end

    timeslots_hash[:Saturday] = not_soon_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Sat"
    end

    timeslots_hash[:Sunday] = not_soon_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Sun"
    end

    #return a hash with keys of days and values of array of time slots
    timeslots_hash
  end


end
