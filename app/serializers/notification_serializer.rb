class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :notifiable_type, :notifiable_id, :read_at, :summary

  def summary
    Notifier::Presenter::Notification.new(object).present
  end
end
