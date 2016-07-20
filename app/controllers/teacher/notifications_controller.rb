class Teacher::NotificationsController < ApplicationController
  include EnsureTeacher

  def index
    @notifications = current_user.teacher_notifications.unread.paginate(page: params[:page])
  end

  def all
    @notifications = current_user.teacher_notifications.sorted.paginate(page: params[:page])
  end
end
