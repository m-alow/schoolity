class Subject < ActiveRecord::Base
  belongs_to :school_class
  has_many :teachings, dependent: :destroy
  has_many :exams, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: { scope: :school_class_id }
  validates :school_class, presence: true
end
