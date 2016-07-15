class Absence < ActiveRecord::Base
  belongs_to :student
  belongs_to :day

  validates :day, :student, presence: true
end
