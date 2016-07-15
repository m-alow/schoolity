class Student < ActiveRecord::Base
  belongs_to :school
  has_many :studyings
  has_many :following_codes
  has_many :followings
  has_many :activities
  has_many :grades
  has_many :behaviors
  has_many :announcements, as: :announceable
  has_many :absences

  validates :first_name, :last_name, :father_name, presence: true
  validates :birthdate, presence: true
  validates :first_name, :last_name, :father_name, length: { minimum: 2 }
  validates :mother_name, length: { minimum: 2 }, allow_blank: true

  def classroom
    studyings.order(:beginning_date).last&.classroom
  end

  def activity_in lesson
    activities.find_by lesson: lesson
  end

  def behavior_in_lesson lesson
    behaviors.find_by behaviorable: lesson
  end

  def behavior_in_day day
    behaviors.find_by behaviorable: day
  end

  def followed_by? user
    followings.exists? user: user
  end

  def name
    "#{first_name} #{last_name}"
  end

  def full_name
    "#{first_name} #{father_name} #{last_name}"
  end
end
