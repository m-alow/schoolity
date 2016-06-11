class DayPolicy < ApplicationPolicy
  def index?
    user.owns?(record.school) || user.administrates?(record.school) ||
      user.teaches_in_classroom?(record) || user.follows_student_in_classroom?(record)
  end

  def show_by_date?
    user.owns?(school) || user.administrates?(school) ||
      user.teaches_in_classroom?(record.classroom) || user.follows_student_in_classroom?(record.classroom)
  end

  alias_method :today?, :show_by_date?

  def edit?
    user.owns?(school) || user.administrates?(school) ||
      user.teaches_in_classroom?(record.classroom)
  end

  alias_method :update?, :edit?

  def destroy?
    user.owns?(school) || user.administrates?(school)
  end

  private
  def school
    record.classroom.school
  end
end
