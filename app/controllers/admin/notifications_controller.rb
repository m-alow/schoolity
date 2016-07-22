class Admin::NotificationsController < ApplicationController
  include EnsureAdmin

  def index
    @notifications = current_user.admin_notifications.unread.paginate(page: params[:page])
  end

  def all
    @notifications = current_user.admin_notifications.paginate(page: params[:page])
  end
end
