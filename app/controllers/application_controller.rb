class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login

  private

  def require_login
    if current_student.nil?
      redirect_to root_path
    end
  end

  def current_student
    @current_student ||= Student.find_by_id(session[:student_id]) if session[:student_id]
  end

  def set_time_zone
    redirect_to timezone_path
  end
end
