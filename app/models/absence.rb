class Absence < ActiveRecord::Base
  belongs_to :student
  belongs_to :day
  has_many :notifications, as: :notifiable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :day, :student, presence: true

  scope :sorted, -> { includes(:day).sort_by { |a| a.day.date }.reverse }
end
