module AuthenticationHelper
  def convert_date(date)
    timezone_str = Student.find(session[:student_id]).time_zone
    newzone = ActiveSupport::TimeZone.new(timezone_str)
    oldzone = date.zone

  end
end
