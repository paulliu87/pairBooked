module TimeslotsHelper

  def show_time_options
    [
      ['12:00AM', "00:00"],
      ['1:00AM', "01:00"],
      ['2:00AM', "02:00"],
      ['3:00AM', "03:00"],
      ['4:00AM', "04:00"],
      ['5:00AM', "05:00"],
      ['6:00AM', "06:00"],
      ['7:00AM', "07:00"],
      ['8:00AM', "08:00"],
      ['9:00AM', "09:00"],
      ['10:00AM', "10:00"],
      ['11:00AM', "11:00"],
      ['12:00PM', "12:00"],
      ['1:00PM', "13:00"],
      ['2:00PM', "14:00"],
      ['3:00PM', "15:00"],
      ['4:00PM', "16:00"],
      ['5:00PM', "17:00"],
      ['6:00PM', "18:00"],
      ['7:00PM', "19:00"],
      ['8:00PM', "20:00"],
      ['9:00PM', "21:00"],
      ['10:00PM', "22:00"],
      ['11:00PM', "23:00"]
    ]
  end

  def timeslot_string(timeslot)
    timeslot.start_at.in_time_zone(current_time_zone).strftime("%B %d %Y from %l:%M %P") + " to " + timeslot.end_at.strftime("%l:%M %P")

  end
end
