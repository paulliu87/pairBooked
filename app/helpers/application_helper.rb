module ApplicationHelper
  def current_student
    @current_student ||= Student.find_by_id(session[:student_id]) if session[:student_id]
  end

  def current_time_zone
    if current_student
      current_student.time_zone
    else
      Time.zone.name.to_s
    end
  end
    # helper_method :current_student #make this method available in views
end
