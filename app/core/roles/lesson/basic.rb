module Roles
  module Lesson
    module Basic
      def initialize_content
        self.content = { title: '', summary: '', homework: '' } unless content
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

      def homework
        content[:homework]
      end

      def homework= homework
        content[:homework] = homework
      end


      def update_content **params
        tap do |lesson|
          lesson.title = params[:title] if params[:title]
          lesson.summary = params[:summary] if params[:summary]
          lesson.homework = params[:homework] if params[:homework]
        end
      end
    end
  end
end
