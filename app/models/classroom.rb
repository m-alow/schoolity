class Classroom < ActiveRecord::Base
  belongs_to :school_class
  has_many :studyings, dependent: :destroy
  has_many :students, through: :studyings
  delegate :school, to: :school_class
  has_many :teachings, dependent: :destroy
  has_many :timetables, dependent: :destroy
  has_many :days, dependent: :destroy
  has_many :exams, dependent: :destroy
  has_many :announcements, as: :announceable, dependent: :destroy

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

  def day_at date
    days.find_by date: date
  end
end
