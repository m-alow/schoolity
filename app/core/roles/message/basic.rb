module Roles
  module Message
    module Basic
      def initialize_content
        self.content = { subject: '', body: '' } unless content
        raise unless content.is_a? Hash
      end

      def subject
        content[:subject]
      end

      def subject= subject
        content[:subject] = subject
      end

      def body
        content[:body]
      end

      def body= body
        content[:body] = body
      end

      def update_content **params
        tap do |message|
          message.subject = params[:subject] if params[:subject]
          message.body = params[:body] if params[:body]
        end
      end
    end
  end
end
