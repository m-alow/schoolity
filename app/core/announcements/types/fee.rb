module Announcements
  module Types
    class Fee
      attr_reader :fee, :date
      def initialize attributes
        @fee = attributes[:fee]

        d = attributes[:date]
        @date = "#{d[:year]}-#{d[:month]}-#{d[:day]}".to_date
      end

      def call
        {
          title: title,
          body: body
        }
      end

      private

      def title
        'Fee Reminder'
      end

      def body
        "This is just a friendly reminder that your June fee of #{fee} is overdue.
 If you have not already sent the payment, please do it before #{formatted_date}."
      end

      def formatted_date
        date.strftime '%A, %d %B %Y'
      end
    end
  end
end
