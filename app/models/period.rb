class Period < ActiveRecord::Base
  belongs_to :timetable
  belongs_to :subject

  validates :timetable, :day, :order, presence: true
  validates_numericality_of :order, only_integer: true,
                            greater_than: 0,
                            less_than_or_equal:  ->(period) { periods.timetable.periods_number }
  validates :day, inclusion: { in: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'] }
  validates :order, uniqueness: { scope: [:timetable_id, :day] }
  validates :subject, inclusion: { in: ->(period) { period.timetable.classroom.school_class.subjects } }, allow_nil: true
end
