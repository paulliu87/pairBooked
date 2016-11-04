class TimeslotsController < ApplicationController

  def index
    @timeslots = Timeslot.where(challenge_id: params["challenge_id"], acceptor: nil)
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
end
