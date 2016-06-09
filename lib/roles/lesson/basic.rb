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
    end
  end
end
