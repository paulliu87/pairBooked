class ChallengesController < ApplicationController
  def index
    @page_title = "Challenges"
    @challenges = Challenge.all
  end
end
