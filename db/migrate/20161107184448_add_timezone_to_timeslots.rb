class AddTimezoneToTimeslots < ActiveRecord::Migration[5.0]
  def change
    add_column :timeslots, :time_zone, :string, :default => "Pacific Time (US & Canada)"
  end
end
