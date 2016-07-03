module Notifier
  module Publishers
    module Persist
      class Create
        def call scope, notifiable
          scope.call.each do |user|
            Notification.create notifiable: notifiable,
                                recipient: user,
                                recipient_role: scope.role
          end
        end
      end
    end
  end
end
