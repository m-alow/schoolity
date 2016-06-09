module Roles
  module Day
    module Basic
      def initialize_content
        self.content = { summary: '' } unless content
        raise unless content.is_a? Hash
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
