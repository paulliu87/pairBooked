class TimeslotsController < ApplicationController
  include TimeslotsHelper
  include Mail
  def index
    @challenge = Challenge.find_by_id(params[:challenge_id])
    if @challenge
      @page_title = "#{@challenge.name}"
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
    @challenge = Challenge.find_by_id(params[:challenge_id])
    @page_title = "Input availability for #{@challenge.name}"
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

end
