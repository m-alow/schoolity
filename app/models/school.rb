class School < ActiveRecord::Base
  has_many :school_classes
  has_many :classes, through: :school_classes
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'

  validates :name, presence: true
end
