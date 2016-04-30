class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :lockable

  has_many :schools
  has_many :school_administrations
  has_many :administrated_schools, through: :school_administrations, class_name: 'School', foreign_key: 'school_id'

  validates :first_name, presence: true
  validates :last_name, presence: true

  def name
    [first_name, last_name].join(' ')
  end

  def administrates?(school)
    administrated_schools.include? school
  end
end
