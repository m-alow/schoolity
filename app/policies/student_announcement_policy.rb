class StudentAnnouncementPolicy < ApplicationPolicy
  def index?
    raise unless record.is_a? Student
    user.owns?(record.school) ||
      user.administrates?(record.school) ||
      user.follows?(record)
  end

  def show?
    user.owns?(school) ||
      user.administrates?(school) ||
      user.follows?(student)
  end

  def new?
    user.owns?(school) ||
      user.administrates?(school)
  end

  def edit?
    user.authors?(record) &&
      (user.owns?(school) ||
       user.administrates?(school))
  end

  alias_method :create?, :new?
  alias_method :update?, :edit?
  alias_method :destroy?, :edit?

  private

  def student
    record.announceable
  end

  def school
    student.school
  end
end
