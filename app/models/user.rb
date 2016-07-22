class User < ActiveRecord::Base
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :lockable, :trackable

  has_many :schools, dependent: :destroy
  has_many :school_administrations, dependent: :destroy
  has_many :administrated_schools, through: :school_administrations, class_name: 'School', foreign_key: 'school_id'
  has_many :teachings, dependent: :destroy
  has_many :followings, dependent: :destroy
  has_many :notifications, foreign_key: 'recipient_id', dependent: :destroy
  has_many :device_tokens, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true

  def name
    [first_name, last_name].join(' ')
  end

  def administrates?(school)
    administrated_schools.include? school
  end

  def school_admin?
    !administrated_schools.empty?
  end

  def owns?(school)
    self == school.owner
  end

  def authors? announcement
    self == announcement.author
  end

  def parent?
    !followings.empty?
  end

  def parent_notifications
    notifications.where(recipient_role: 'Follower').order(updated_at: :desc)
  end

  def parent_feed notifications
    notifications.includes(:notifiable).map { |n| [n, n.notifiable] }
  end

  def follows? student
    followings.exists? student: student
  end

  def follows_student_in_classroom? classroom
    classroom.students.exists? id: self.followings.select(:student_id)
  end

  def follows_student_in_school? school
    school.students.exists? id: self.followings.select(:student_id)
  end

  def follows_student_in_school_class? school_class
    followings.exists? student_id: school_class.current_students
  end

  def teacher_notifications
    notifications.where(recipient_role: 'Teacher').sorted
  end

  def teacher_feed
    teacher_notifications.includes(:notifiable).map { |n| [n, n.notifiable] }
  end

  def teacher?
    !teachings.empty?
  end

  def teaches_in_classroom? classroom
    teachings.exists? classroom: classroom
  end

  def teaches_all_subjects_in_classroom? classroom
    teachings.exists? classroom: classroom, all_subjects: true
  end

  def teaches_subject_in_classroom? subject, classroom
    return false if subject.nil?
    teachings.exists?(classroom: classroom, subject: subject) || teachings.exists?(classroom: classroom, all_subjects: true)
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

  def teaches_student_a_subject? student, subject
    teaches_subject_in_classroom?(subject, student.classroom)
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

  def admin_notifications
    notifications.where(recipient_role: 'Admin').sorted
  end

  def admin_feed notifications
    notifications.includes(:notifiable).map { |n| [n, n.notifiable] }
  end
end
