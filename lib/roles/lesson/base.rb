module Roles
  module Lesson
    module Base
      def initialize_content
        self.content = {} unless content
        raise unless content.is_a? Hash
      end
    end
  end
end
