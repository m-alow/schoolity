module Notifier
  module Publishers
    module Gcm
      class Create
        attr_reader :gcm
        def initialize
          @gcm = GCM.new 'AIzaSyAgjbteGB9sFfOuQVXc8lPviP8yPNOy5QM'
        end

        def call scope, notifiable
          GcmNotificationsJob.perform_later 'Create', scope.call.to_a, notifiable, scope.role
        end

        def send_notifications subscribers, notifiable, role
          tokens = DeviceToken
                   .select(:token)
                   .where(user: subscribers.map(&:id),
                          role: role)
                   .map(&:token)

          return if tokens.empty?

          notification = {
            notifiable_type: notifiable.class.name,
            notifiable_id: notifiable.id,
            summary: Notifier::Presenter::Notifiable.new(notifiable).present,
            role: role
          }

          response = gcm.send tokens, { data: notification }
          Rails.logger.info "Send GCM Notification: #{notification}"
          Rails.logger.info JSON.pretty_generate response
        end
      end
    end
  end
end
