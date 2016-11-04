class Student < ApplicationRecord
  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email
end
