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
    @timeslot = Timeslot.find(params[:id])
    @timeslot.acceptor = current_student
    @timeslot.save
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
    p params
    @timeslot = Timeslot.new(start_at: params[:start_date], start_time: params[:start_time], end_time: params[:end_time])
    respond_to do |format|
      if @timeslot.save
        format.html { redirect_to "challenges/#{params[:challenge_id]}/timeslots", notice: 'Tweet was successfully created.' }
        format.json { render json: @timeslot, status: :created}
      else
        format.html { render action: "new" }
        format.json { render json: @timeslot.errors, status: :unprocessable_entity }
      end
    end
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

  def timeslots_params
    params.require(:timeslots).permit(:start_date, :start_time, :end_time, :location, :season)
  end
end
