module Announcements
  module Types
    class Exam
      attr_reader :subject, :date
      def initialize attributes
        @subject = attributes[:subject]

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
        'Exam Time'
      end

      def body
        "There will be a #{subject} exam on #{formatted_date}."
      end

      def formatted_date
        date.strftime '%A, %d %B %Y'
      end
    end
  end
end
