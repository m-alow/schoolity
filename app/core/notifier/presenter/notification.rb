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
        notifiable = notification.notifiable
        unless notifiable.comments.empty?
          Notifier::Presenter::Comment.new(notifiable)
        else
          "Notifier::Presenter::#{notifiable.class.name}".constantize.new(notifiable)
        end
      end
    end
  end
end
