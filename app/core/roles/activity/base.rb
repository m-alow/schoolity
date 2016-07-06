module Roles
  module Activity
    module Base
      def initialize_content
        self.content = {} unless content
        raise unless content.is_a? Hash
      end


      def update_content **params
        self
      end
    end
  end
end
