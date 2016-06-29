class SchoolClass < ActiveRecord::Base
  belongs_to :school
  has_many :classrooms
  has_many :subjects
  has_many :announcements, as: :announceable

  validates :name, presence: true
  validates :name, uniqueness: { scope: :school_id }
end
