module Roles
  module Behavior
    module Basic
      def initialize_content
        self.content = { notes: '' } unless content
        raise unless content.is_a? Hash
      end

      def notes
        content[:notes]
      end

      def notes= notes
        content[:notes] = notes
      end

      def update_content **params
        tap do |behavior|
          behavior.notes = params[:notes] if params[:notes]
        end
      end
    end
  end
end
