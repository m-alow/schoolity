module Notifier
  module Publishers
    module Persist
      class Create
        def call scope, notifiable
          PersistNotificationsJob.perform_later 'Create', scope.call.to_a, notifiable, scope.role
        end

        def persist_notifications subscribers, notifiable, role
          Notification.transaction do
            subscribers.each do |user|
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
