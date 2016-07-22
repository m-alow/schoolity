class School < ActiveRecord::Base
  has_many :school_classes, dependent: :destroy
  has_many :classrooms, through: :school_classes
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  has_many :school_administrations, dependent: :destroy
  has_many :administrators, through: :school_administrations, class_name: 'User', foreign_key: 'user_id'
  has_many :students, dependent: :destroy
  has_many :announcements, as: :announceable, dependent: :destroy

  validates :name, presence: true

  def administrated_by?(user)
    administrators.include? user
  end

  def owned_by?(user)
    owner == user
  end

  def messages
    Message.where(student_id: students).includes(:student, :user)
  end
end
