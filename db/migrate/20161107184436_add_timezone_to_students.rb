class AddTimezoneToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :time_zone, :string, :default => "Pacific Time (US & Canada)"
  end
end
