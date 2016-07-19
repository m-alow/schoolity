module Roles
  module Activity
    module Rated
      SCALE = %w(Undone Inadequate Fair Adequate Good Excellent)

      def initialize_content
        self.content = { homework: nil,
                         participation: nil,
                         assessment: nil,
                         other: { name: nil, rating: nil },
                         notes: nil } unless content
        raise unless content.is_a? Hash
      end

      def homework
        content[:homework]
      end

      def homework= homework
        content[:homework] = homework
      end

      def participation
        content[:participation]
      end

      def participation= participation
        content[:participation] = participation
      end

      def assessment
        content[:assessment]
      end

      def assessment= assessment
        content[:assessment] = assessment
      end

      def other
        content[:other]
      end

      def other= other
        content[:other] = other
      end

      def notes
        content[:notes]
      end

      def notes= notes
        content[:notes] = notes
      end

      def update_content **params
        tap do |activity|
          activity.homework = rate params[:homework] if params[:homework].present?
          activity.assessment = rate params[:assessment] if params[:assessment].present?
          activity.participation = rate params[:participation] if params[:participation].present?
          activity.notes = params[:notes] if params[:notes].present?
          if params[:other]
            activity.other[:name] = params[:other][:name]
            activity.other[:rating] = rate params[:other][:rating] if params[:other][:rating].present?
          end
        end
      end

      private

      def rate r
        SCALE.detect { |s| s == r }
      end
    end
  end
end
