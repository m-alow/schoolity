class Classroom < ActiveRecord::Base
  belongs_to :school_class

  validates :name, presence: true
  validates :name, uniqueness: { scope: :school_class_id }
end
