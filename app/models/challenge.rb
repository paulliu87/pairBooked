class Challenge < ApplicationRecord
  validates_presence_of :due_date, :name
end
