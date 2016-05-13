class Studying < ActiveRecord::Base
  belongs_to :classroom
  belongs_to :student

  validates :classroom, :student, :beginning_date, presence: true
end
