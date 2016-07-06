module Roles
  module Activity
    module Basic
      def initialize_content
        self.content = { notes: '', rating: nil } unless content
        raise unless content.is_a? Hash
      end

      def notes
        content[:notes]
      end

      def notes= notes
        content[:notes] = notes
      end

      def rating
        content[:rating]
      end

      def rating= rating
        content[:rating] = rating.to_i
      end


      def update_content **params
        tap do |activity|
          activity.notes = params[:notes] if params[:notes]
          activity.rating = params[:rating] if params[:rating]
        end
      end
    end
  end
end
