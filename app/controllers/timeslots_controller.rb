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
    @timeslot = Timeslot.find_by_id(params[:id])
    @timeslot.acceptor = current_student
    @timeslot.save!

    empty_timeslots = Timeslot.where(initiator_id: @timeslot.initiator_id, challenge_id: @timeslot.challenge_id, acceptor_id: nil)
    empty_timeslots.each do |timeslot|
      timeslot.destroy
    end
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
      # render json: @timeslot.errors, status: :unprocessable_entity
    else
      create_timeslots(sanitized_params[:start_at],sanitized_params[:end_at],current_student.id, @challenge)
      redirect_to "/challenges/#{params[:challenge_id]}/timeslots", notice: 'Tweet was successfully created.'
      # render json: @timeslot, status: :created
    end




    # respond_to do |format|
    #   if @timeslot.save
    #     format.html { redirect_to "/challenges/#{params[:challenge_id]}/timeslots", notice: 'Tweet was successfully created.' }
    #     format.json { render json: @timeslot, status: :created}
    #   else
    #     @errors = @timeslot.errors.full_messages
    #     format.html { render action: "new" }
    #     format.json { render json: @timeslot.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  private
  def get_timeslots(challenge_id)
    timeslots = {}
    all_timeslots = Timeslot.where(challenge_id: challenge_id, acceptor: nil).order("start_at ASC")

    timeslots[:Monday] = all_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Mon" && timeslot.initiator != current_student
    end

    timeslots[:Tuesday] = all_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Tue" && timeslot.initiator != current_student
    end

    timeslots[:Wednesday] = all_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Wed" && timeslot.initiator != current_student
    end

    timeslots[:Thursday] = all_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Thu" && timeslot.initiator != current_student
    end

    timeslots[:Friday] = all_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Fri" && timeslot.initiator != current_student
    end

    timeslots[:Saturday] = all_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Sat" && timeslot.initiator != current_student
    end

    timeslots[:Sunday] = all_timeslots.select do |timeslot|
      timeslot.start_at.strftime("%a") == "Sun" && timeslot.initiator != current_student
    end

    #return a hash with keys of days and values of array of time slots
    timeslots
  end

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
end
