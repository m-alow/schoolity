module Notifier
  module Presenter
    class Message
      attr_reader :message
      def initialize message
        @message = message
      end

      def present
        "New #{summary}"
      end

      def summary
        "#{message.message_type.humanize} about #{message.student.name} by #{message.user.name}"
      end
    end
  end
end
