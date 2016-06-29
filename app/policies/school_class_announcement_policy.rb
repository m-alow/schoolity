class SchoolClassAnnouncementPolicy < ApplicationPolicy
  def index?
    raise unless record.is_a? SchoolClass
    user.owns?(record.school) ||
      user.administrates?(record.school) ||
      user.teaches_in_school_class?(record) ||
      user.follows_student_in_school_class?(record)
  end

  def show?
    user.owns?(school) ||
      user.administrates?(school) ||
      user.teaches_in_school_class?(school_class) ||
      user.follows_student_in_school_class?(school_class)
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

  def school_class
    record.announceable
  end

  def school
    school_class.school
  end
end
