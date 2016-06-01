class Following < ActiveRecord::Base
  belongs_to :user
  belongs_to :student

  validates :user, :student, :relationship, presence: true
  validates :student_id, uniqueness: { scope: :user_id }
end
