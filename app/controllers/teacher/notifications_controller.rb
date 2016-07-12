class Teacher::NotificationsController < ApplicationController
  include EnsureTeacher

  def index
    @notifications = current_user.teacher_notifications.unread
  end

  def all
    @notifications = current_user.teacher_notifications.sorted
  end
end
