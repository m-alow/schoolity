module Roles
  module Lesson
    module Basic
      def initialize_content
        self.content = { title: '', summary: '' } unless content
        raise unless content.is_a? Hash
      end

      def title
        content[:title]
      end

      def title= title
        content[:title] = title
      end

      def summary
        content[:summary]
      end

      def summary= summary
        content[:summary] = summary
      end


      def update_content **params
        tap do |lesson|
          lesson.title = params[:title] if params[:title]
          lesson.summary = params[:summary] if params[:summary]
        end
      end
    end
  end
end
