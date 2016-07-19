module Roles
  module Behavior
    module Rated
      SCALE = %w(Introvert Calm Normal Turbulent Bully)

      def initialize_content
        self.content = { rating: nil,
                         notes: nil } unless content
        raise unless content.is_a? Hash
      end

      def rating
        content[:rating]
      end

      def rating= rating
        content[:rating] = rating
      end

      def notes
        content[:notes]
      end

      def notes= notes
        content[:notes] = notes
      end

      def update_content **params
        tap do |behavior|
          behavior.rating = rate params[:rating] if params[:rating].present?
          behavior.notes = params[:notes] if params[:notes].present?
        end
      end

      private

      def rate r
        SCALE.detect { |s| s == r }
      end
    end
  end
end
