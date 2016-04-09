class School < ActiveRecord::Base
  has_many :school_classes

  validates :name, presence: true
end
