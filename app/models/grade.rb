class Grade < ActiveRecord::Base
  belongs_to :exam
  belongs_to :student

  validates :exam, :student, :score, presence: true
  validates :score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: ->(g) { g.exam.score.to_i } }

  validates :student_id, uniqueness: { scope: :exam_id }

  def pass?
    exam.minimum_score.nil? || score >= exam.minimum_score
  end

  def fail?
    !pass?
  end
end
