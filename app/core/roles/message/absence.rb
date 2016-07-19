module Roles
  module Message
    module Absence
      def initialize_content
        self.content = { date: nil, reason: nil } unless content
        raise unless content.is_a? Hash
      end

      def date
        content[:date]
      end

      def date= date
        content[:date] = date.to_date
      end

      def reason
        content[:reason]
      end

      def reason= reason
        content[:reason] = reason
      end

      def update_content **params
        tap do |message|
          if params[:"date(1i)"].present?
            message.date = "#{params[:"date(1i)"]}-#{params[:"date(2i)"]}-#{params[:"date(3i)"]}"
          end
          message.reason = params[:reason] if params[:reason]
        end
      end
    end
  end
end
