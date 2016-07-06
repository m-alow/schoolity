module Notifier
  module Publishers
    module Persist
      class Update
        def call scope, notifiable
          scope.call.each do |user|
            notification = Notification.find_by recipient_id: user, notifiable: notifiable, recipient_role: scope.role
            if notification.present?
              notification.touch
              notification.update read_at: nil
            else
              Notification.create notifiable: notifiable,
                                  recipient: user,
                                  recipient_role: scope.role
            end
          end
        end
      end
    end
  end
end
