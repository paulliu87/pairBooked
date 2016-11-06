class AuthenticationController < ApplicationController
  
  skip_before_action :require_login, only: [:index, :login]
  
  def index
  end

  def login
    omniauth_hash = request.env["omniauth.auth"]
    student = Student.find_by(
      username: omniauth_hash["uid"]
    ) || Student.create_with_omniauth(omniauth_hash)
    session[:student_id] = student.id
    # redirect_to slack_entry_url if student.slack_name == nil
    redirect_to challenges_path, :notice => "Signed in!"
  end

  def logout
    session[:student_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

  def dashboard
    @student = current_student
  end
end
