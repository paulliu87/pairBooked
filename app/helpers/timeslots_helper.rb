module TimeslotsHelper
  def timeslot_string(timeslot)
    timeslot.start_at.in_time_zone(current_time_zone).strftime("%B %d %Y from %l:%M %P") + " to " + timeslot.end_at.strftime("%l:%M %P")
  end
end
