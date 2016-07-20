module Notifier
  module Presenter
    class Notifiable
      attr_reader :notifiable, :presenter

      def initialize notifiable
        @notifiable = notifiable
        @presenter = presenter_of notifiable
      end

      def present
        presenter.present
      end

      private

      def presenter_of notifiable
        unless notifiable.comments.empty?
          Notifier::Presenter::Comment.new(notifiable)
        else
          "Notifier::Presenter::#{notifiable.class.name}".constantize.new(notifiable)
        end
      end
    end
  end
end
