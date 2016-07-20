class GcmNotificationsJob < ActiveJob::Base
  queue_as :default

  def perform publisher, subscribers, notifiable, role
    "Notifier::Publishers::Gcm::#{publisher}"
      .constantize
      .new
      .send_notifications subscribers, notifiable, role
  end
end
