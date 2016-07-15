class Absence < ActiveRecord::Base
  belongs_to :student
  belongs_to :day
  has_many :notifications, as: :notifiable, dependent: :delete_all
  has_many :comments, as: :commentable, dependent: :delete_all

  validates :day, :student, presence: true
end
