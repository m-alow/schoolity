class School < ActiveRecord::Base
  has_many :school_classes
  has_many :classrooms, through: :school_classes
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  has_many :school_administrations
  has_many :administrators, through: :school_administrations, class_name: 'User', foreign_key: 'user_id'
  has_many :students

  validates :name, presence: true

  def administrated_by?(user)
    administrators.include? user
  end

  def owned_by?(user)
    owner == user
  end
end
