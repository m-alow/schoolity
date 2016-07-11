class PersistNotificationsJob < ActiveJob::Base
  queue_as :default

  def perform publisher, subscribers, notifiable, role
    "Notifier::Publishers::Persist::#{publisher}"
      .constantize
      .new
      .persist_notifications subscribers, notifiable, role
  end
end
