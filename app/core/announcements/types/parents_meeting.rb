module Announcements
  module Types
    class ParentsMeeting
      attr_reader :reason, :time
      def initialize attributes
        @reason = attributes[:reason]
        d = attributes[:time]
        @time = "#{d[:year]}-#{d[:month]}-#{d[:day]} #{d[:hour]}:#{d[:minute]}".to_time
      end

      def call
        {
          title: title,
          body: body
        }
      end

      private

      def title
        'Call up'
      end

      def body
        "There will be a parents meeting on #{formatted_time}. #{reason}"
      end

      def formatted_time
        time.strftime '%A, %d %B %Y %l:%M %p'
      end
    end
  end
end
