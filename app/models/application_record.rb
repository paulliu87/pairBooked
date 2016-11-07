class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def time_zone
    @time_zone ||= ActiveSupport::TimeZone.new("Pacific Time (US & Canada)")
  end
end
