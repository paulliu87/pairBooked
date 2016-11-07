class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def time_zone=(new_time_zone)
    @time_zone = ActiveSupport::TimeZone.new(new_time_zone) if new_time_zone.is_a? String
    @time_zone = new_time_zone if new_time_zone.is_a? ActiveSupport::TimeZone
  end
  def time_zone
      @time_zone ||= ActiveSupport::TimeZone.new("Pacific Time (US & Canada)")
  end
end
