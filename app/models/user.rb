class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :lockable, :trackable

  has_many :schools
  has_many :school_administrations
  has_many :administrated_schools, through: :school_administrations, class_name: 'School', foreign_key: 'school_id'
  has_many :teachings
  has_many :followings

  validates :first_name, presence: true
  validates :last_name, presence: true

  def name
    [first_name, last_name].join(' ')
  end

  def administrates?(school)
    administrated_schools.include? school
  end

  def owns?(school)
    self == school.owner
  end

  def follows? student
    followings.exists? student: student
  end

  def teaches_in_classroom? classroom
    teachings.exists? classroom: classroom
  end

  def teaches_in_school_class? school_class
    teachings.exists? classroom: school_class.classrooms
  end

  def teaches_in_school? school
    teachings.exists? classroom: school.classrooms
  end

  def teaches_student? student
    teaches_in_classroom? student.classroom
  end

  def follow_student(code:, relationship:, full_name:)
    following_code = FollowingCode.find_by(code: code)
    if following_code.nil? || following_code.expired?
      followings.build relationship: relationship
    else
      student = following_code.student
      if student.full_name == full_name
        followings.build(
          student: student,
          relationship: relationship)
      else
        followings.build relationship: relationship
      end
    end
  end
end
