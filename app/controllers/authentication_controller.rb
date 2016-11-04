class AuthenticationController < ApplicationController
  def index
  end

  def login
    auth = request.env["omniauth.auth"]
    student = Student.find_by_provider_and_uid(
      auth["provider"],
      auth["uid"]
    ) || Student.create_with_omniauth(auth)
    session[:student_id] = student.id
    # redirect_to slack_entry_url if student.slack_name == nil
    redirect_to root_url, :notice => "Signed in!"
  end

  def logout
    session[:student_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
