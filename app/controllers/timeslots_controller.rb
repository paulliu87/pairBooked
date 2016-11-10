class TimeslotsController < ApplicationController
  include TimeslotsHelper
  def index
    @challenge = Challenge.find_by_id(params[:challenge_id])
    if @challenge
      @not_soon_timeslots = @challenge.get_not_soon_timeslots(current_student)
      @soon_timeslots = @challenge.get_soon_timeslots(current_student)
    else
      redirect_to challenges_path
    end
  end

  def accept
    @timeslot = Timeslot.find_by_id(params[:id])
    @timeslot.acceptor = current_student
    if @timeslot.save
      empty_timeslots = Timeslot.where(initiator_id: @timeslot.initiator_id, challenge_id: @timeslot.challenge_id, acceptor_id: nil)
      empty_timeslots.each do |timeslot|
        timeslot.destroy
      end

      overlap_timeslots = Timeslot.where(initiator_id: @timeslot.initiator_id, start_at: @timeslot.start_at, acceptor_id: nil)
      overlap_timeslots.each do |timeslot|
        timeslot.destroy
      end
      send_confirmation(@timeslot)
    end
    redirect_to challenge_timeslot_path(@timeslot.challenge_id, @timeslot)
  end

  def show
    @timeslot = Timeslot.find_by_id(params[:id])
    @page_title = @timeslot.challenge.name + " timeslots"
  end

  def destroy
    Timeslot.destroy(params[:id])
    redirect_to dashboard_path
  end

  def new
  end

  def create
    sanitized_params = timeslots_params
    if sanitized_params[:start_date] != "" && sanitized_params[:start_time] != "" && sanitized_params[:end_time] != ""
      convert_to_datetime(sanitized_params)
    end
    @challenge = Challenge.find_by_id(params[:challenge_id])

    if sanitized_params[:end_at] <= sanitized_params[:start_at]
      @errors = ["Start time must before end time."]
      render action: "new"
    elsif sanitized_params[:start_at] <= DateTime.now
      @errors = ["Start time must after the current time."]
      render action: "new"
    else
      create_timeslots(sanitized_params[:start_at],sanitized_params[:end_at],current_student.id, @challenge)
      redirect_to "/challenges/#{params[:challenge_id]}/timeslots", notice: 'Tweet was successfully created.'
    end
  end

  def cancel
    timeslot = Timeslot.find(params[:id])
    send_cancellation(timeslot)
    timeslot.destroy
    redirect_to dashboard_path
  end

  private

  def timeslots_params
    params.require(:timeslots).permit( :start_date, :start_time, :end_time)
  end

  def convert_to_datetime(params)
    start_datetime = params[:start_date] + params[:start_time]
    params[:start_at] = DateTime.strptime(start_datetime + current_time_zone.to_s[-3..-1],'%F%H:%M %Z')
    end_datetime = params[:start_date] + params[:end_time]
    params[:end_at] = DateTime.strptime(end_datetime + current_time_zone.to_s[-3..-1],'%F%H:%M %Z')
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
