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
    timeslot.start_at.in_time_zone(current_time_zone).strftime("%B %d %Y from %l:%M %P") + " to " + timeslot.end_at.in_time_zone(current_time_zone).strftime("%l:%M %P")
  end

  def timeslots_params
    params.require(:timeslots).permit( :start_date, :start_time, :end_time)
  end

  def convert_to_datetime(params)
    start_datetime = params[:start_date] + " " + params[:start_time]
    params[:start_at] = start_datetime.in_time_zone(zone = current_time_zone)
    end_datetime = params[:start_date] + " " + params[:end_time]
    params[:end_at] = end_datetime.in_time_zone(zone = current_time_zone)
  end

  def create_timeslots(start_at, end_at, initiator_id, challenge)
    temp_start_at = start_at + 1.hour
    if duration_greater_than_hour(start_at, end_at)
      create_timeslot(start_at, temp_start_at, initiator_id, challenge)
      create_timeslots(temp_start_at, end_at, initiator_id, challenge)
    else
      create_timeslot(start_at, temp_start_at, initiator_id, challenge)
    end
  end

  def create_timeslot(start_at, end_at, initiator_id, challenge)
    timeslot = challenge.timeslots.new(
      start_at:     start_at,
      end_at:       end_at
      )
    timeslot.initiator_id = initiator_id
    timeslot.save
  end

  def duration_greater_than_hour(start_at, end_at)
    (((end_at.to_time - start_at.to_time) / 3600).round) > 1
  end

  def send_confirmation(timeslot)
    controller = self
    mail = Mail.new do
      from    'bobolinkpairbook@gmail.com'
      subject   "pairBook #{timeslot.challenge.name}"
      delivery_method :sendmail

      html_part do
        content_type 'text/html; charset=UTF-8'
        body controller.render_to_string(
          :locals => {:@timeslot => timeslot},
          :template => :'timeslots/show.html'
        )
      end
    end

    [timeslot.initiator.email, timeslot.acceptor.email].each do |email|
      mail[:to] = email
      mail.deliver
    end
  end

  def send_cancellation(timeslot)
    controller = self
    mail = Mail.new do
      from    'bobolinkpairbook@gmail.com'
      subject   "CANCELLED pairBook #{timeslot.challenge.name}"
      delivery_method :sendmail

      text_part do
        body "Your pairing on #{controller.timeslot_string(timeslot)} was cancelled. Please re-input your availability for this challenge."
      end
    end

    [timeslot.initiator.email, timeslot.acceptor.email].each do |email|
      mail[:to] = email
      mail.deliver
    end
  end
end
