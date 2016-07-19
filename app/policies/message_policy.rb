class MessagePolicy < ApplicationPolicy
  def show?
    school = record.student.school
    user.owns?(school) ||
      user.administrates?(school) ||
      (user == record.user && user.follows?(record.student))
  end
end
