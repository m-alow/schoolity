class FollowingCode < ActiveRecord::Base
  belongs_to :student

  validates :student, :code, :expire_at, presence: true
  validates :code, length: { is: 8 }

  def self.make(student)
    new(student: student,
        code: new_code,
        expire_at: 72.hours.from_now)
  end

  def self.make!(student)
    create(student: student,
           code: new_code,
           expire_at: 72.hours.from_now)
  end

  def expired?
    expire_at < DateTime.now
  end

  private

  def self.new_code
    SecureRandom.base64 6
  end
end
