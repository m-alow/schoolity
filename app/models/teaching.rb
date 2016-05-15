class Teaching < ActiveRecord::Base
  belongs_to :teacher, class_name: 'User', foreign_key: 'user_id'
  belongs_to :classroom
  belongs_to :subject

  validates :teacher, presence: true
  validates :classroom, presence: true
  validates :subject, presence: true, unless: :all_subjects
  validates :all_subjects, presence: true, unless: :subject
end
