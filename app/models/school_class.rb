class SchoolClass < ActiveRecord::Base
  belongs_to :school
  has_many :classrooms, dependent: :destroy
  has_many :subjects, dependent: :destroy
  has_many :announcements, as: :announceable, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: { scope: :school_id }

  def current_students
    Student.where id: Studying.select(:student_id).where(classroom: classrooms)
  end
end
