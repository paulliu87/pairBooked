class TimeslotsController < ApplicationController

  def index
    @challenge = Challenge.find_by_id(params[:challenge_id])
    if @challenge
      @timeslots = get_timeslots(@challenge.id)
    else
      redirect_to challenges_path
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def new
  end

  def create

  end

  private
  def get_timeslots(challenge_id)
    #take a challenge id
    all_timeslots = Timeslot.where(challenge_id: challenge_id, acceptor: nil)
    timeslots = {}

    timeslots[:Monday] = all_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Mon"
    end

    timeslots[:Tuesday] = all_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Tue"
    end

    timeslots[:Wednesday] = all_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Wed"
    end

    timeslots[:Thursday] = all_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Thu"
    end

    timeslots[:Friday] = all_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Fri"
    end

    timeslots[:Saturday] = all_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Sat"
    end

    timeslots[:Sunday] = all_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Sun"
    end

    #return a hash with keys of days and values of array of time slots
    timeslots
  end
end
