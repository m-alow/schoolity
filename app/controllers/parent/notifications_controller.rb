class Parent::NotificationsController < ApplicationController
  include EnsureParent

  def index
    @notifications = current_user.parent_notifications.unread.paginate(page: params[:page])
  end

  def all
    @notifications = current_user.parent_notifications.sorted.paginate(page: params[:page])
  end
end
