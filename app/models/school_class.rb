class SchoolClass < ActiveRecord::Base
  belongs_to :school

  validates :name, presence: true
  validates :name, uniqueness: { scope: :school_id }
end
