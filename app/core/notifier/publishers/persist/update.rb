module Notifier
  module Publishers
    module Persist
      class Update
        def call scope, notifiable
          PersistNotificationsJob.perform_later 'Update', scope.call.to_a, notifiable, scope.role
        end

        def persist_notifications subscribers, notifiable, role
          Notification.transaction do
            subscribers.each do |user|
              notification = Notification.find_by recipient_id: user, notifiable: notifiable, recipient_role: role
              if notification.present?
                notification.touch
                notification.update read_at: nil
              else
                Notification.create notifiable: notifiable,
                                    recipient: user,
                                    recipient_role: role
              end
            end
          end
        end
      end
    end
  end
end
