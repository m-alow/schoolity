module Notifier
  module Presenter
    class Notification
      attr_reader :notification, :presenter

      def initialize notification
        @notification = notification
        @presenter = presenter_of notification
      end

      def present
        presenter.present
      end

      private

      def presenter_of notification
        Notifier::Presenter::Comment.new(notification.notifiable)
      end
    end
  end
end
