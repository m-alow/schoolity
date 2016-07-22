module Notifier
  module Publishers
    module Gcm
      class Create
        attr_reader :gcm
        def initialize
          @gcm = GCM.new ENV['GCM_API_KEY']
        end

        def call scope, notifiable
          GcmNotificationsJob.perform_later 'Create', scope.call.to_a, notifiable, scope.role
        end

        def send_notifications subscribers, notifiable, role
          tokens = DeviceToken
                   .select(:token)
                   .where(user: subscribers.map(&:id),
                          role: role,
                          enabled: true)
                   .map(&:token)

          return if tokens.empty?

          notification = {
            notifiable_type: notifiable.class.name,
            notifiable_id: notifiable.id,
            summary: Notifier::Presenter::Notifiable.new(notifiable).present,
            role: role,
            notifiable: ActiveModelSerializers::SerializableResource.new(notifiable).to_json
          }

          response = gcm.send tokens, { data: notification }
          Rails.logger.info "Send GCM Notification: #{notification}"
          Rails.logger.info JSON.pretty_generate response
        end
      end
    end
  end
end
