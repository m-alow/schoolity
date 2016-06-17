class Exam < ActiveRecord::Base
  belongs_to :classroom
  belongs_to :subject
  has_many :grades

  accepts_nested_attributes_for :grades

  validates :classroom, :subject, :score, :date, presence: true
  validates :score, numericality: { greater_than: 0 }
  validates :minimum_score, numericality: { greater_than: 0, less_than_or_equal_to: :score }
end
