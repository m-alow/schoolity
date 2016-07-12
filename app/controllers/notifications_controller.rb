class NotificationsController < ApplicationController
  def show
    notification = Notification.find params[:id]
    authorize notification
    notification.mark_read! unless notification.read?
    redirect_to notification.notifiable
  end

  def update
    notification = Notification.find params[:id]
    authorize notification

    if notification.read?
      notification.mark_unread!
    else
      notification.mark_read!
    end

    respond_to do |format|
      format.html { redirect_to notification.notifiable }
      format.js { render locals: { notification: notification } }
    end
  end
end
