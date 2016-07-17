module Announcements
  module Types
    class Holiday
      attr_reader :occasion, :date
      def initialize attributes
        @occasion = attributes[:occasion]

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
        'Holiday'
      end

      def body
        "There will be a holiday on #{formatted_date} on the occasion of #{occasion}."
      end

      def formatted_date
        date.strftime '%A, %d %B %Y'
      end
    end
  end
end
