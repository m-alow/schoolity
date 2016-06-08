class Classroom < ActiveRecord::Base
  belongs_to :school_class
  has_many :studyings
  has_many :students, through: :studyings
  delegate :school, to: :school_class
  has_many :teachings
  has_many :timetables

  validates :name, presence: true
  validates :name, uniqueness: { scope: :school_class_id }

  def following_codes
    FollowingCode.where(student_id: students)
  end

  def current_timetables
    timetables.order(active: :desc, updated_at: :desc)
  end

  def current_timetable
    timetable = timetables.order(active: :desc, updated_at: :desc).first
    timetable&.active? ? timetable : nil
  end
end
