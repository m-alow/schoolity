class Student < ActiveRecord::Base
  belongs_to :school
  has_many :studyings

  validates :first_name, :last_name, :father_name, presence: true
  validates :birthdate, presence: true
  validates :first_name, :last_name, :father_name, :mother_name, length: { minimum: 2 }

  def classroom
    studyings.order(:beginning_date).last&.classroom
  end

  def name
    "#{first_name} #{last_name}"
  end
end
