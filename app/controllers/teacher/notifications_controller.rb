class Teacher::NotificationsController < ApplicationController
  include EnsureTeacher

  def index
    @notifications = current_user.notifications.unread.sorted
  end

  def all
    @notifications = current_user.notifications.sorted
  end
end
