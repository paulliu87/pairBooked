module TimeslotsHelper
  def timeslot_string(timeslot)
    timeslot.start_at.in_time_zone(current_student.time_zone).strftime("%Y %b %d %l:%M %P") + " - " + timeslot.end_at.strftime("%l:%M %P")
  end
end
