class ClassroomAnnouncementPolicy < ApplicationPolicy
  def index?
    raise unless record.is_a? Classroom
    user.owns?(record.school) ||
      user.administrates?(record.school) ||
      user.teaches_in_classroom?(record) ||
      user.follows_student_in_classroom?(record)
  end

  def show?
    user.owns?(school) ||
      user.administrates?(school) ||
      user.teaches_in_classroom?(classroom) ||
      user.follows_student_in_classroom?(classroom)
  end

  def new?
    user.owns?(school) ||
      user.administrates?(school) ||
      user.teaches_in_classroom?(classroom)
  end

  def edit?
    user.authors?(record) &&
      (user.owns?(school) ||
       user.administrates?(school) ||
       user.teaches_in_classroom?(classroom))
  end

  alias_method :create?, :new?
  alias_method :update?, :edit?
  alias_method :destroy?, :edit?

  private

  def classroom
    record.announceable
  end

  def school
    classroom.school
  end
end
