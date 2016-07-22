class Admin::FeedController < ApplicationController
  include EnsureAdmin

  def index
    @notifications = current_user.admin_notifications.paginate page: params[:page]
    @feed = current_user.admin_feed @notifications
  end
end
