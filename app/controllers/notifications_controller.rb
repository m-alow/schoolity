class NotificationsController < ApplicationController
  def show
    notification = Notification.find params[:id]
    authorize notification
    notification.update(read_at: Time.zone.now) unless notification.read?
    redirect_to notification.notifiable
  end
end
