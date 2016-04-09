class School < ActiveRecord::Base
  has_many :school_classes
  has_many :classes, through: :school_classes
  validates :name, presence: true
end
