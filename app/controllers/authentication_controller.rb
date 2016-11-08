class AuthenticationController < ApplicationController

  skip_before_action :require_login, only: [:index, :login, :timezone_form]

  def index
    redirect_to challenges_path if current_student
  end

  def login
    omniauth_hash = request.env["omniauth.auth"]
    student = Student.find_by(
      username: omniauth_hash["info"]["nickname"]
    ) || Student.create_with_omniauth(omniauth_hash)
    session[:student_id] = student.id
    set_time_zone unless student.time_zone
    Time.zone = student.time_zone
    # redirect_to slack_entry_url if student.slack_name == nil
    redirect_to challenges_path, :notice => "Signed in!"
  end

  def logout
    session[:student_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

  def dashboard
    @student = current_student
    @initiated_timeslots = @student.initiated_timeslots
    @unpaired_timeslots = Timeslot.where(initiator: @student, acceptor: nil)
    @paired_timeslots = Timeslot.where(initiator: @student, acceptor: !nil) + @student.accepted_timeslots
  end

  def timezone
    student = Student.find(session[:student_id])
    student.update_attribute(:time_zone, params[:timezone_str])
    Time.zone = params[:timezone_str]
    redirect_to challenges_path
  end

  def timezone_form
    render :'authentication/timezone.html'
  end

end
