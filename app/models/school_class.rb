class SchoolClass < ActiveRecord::Base
  belongs_to :school
  has_many :classrooms
  has_many :subjects

  validates :name, presence: true
  validates :name, uniqueness: { scope: :school_id }
end
