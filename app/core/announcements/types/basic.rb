module Announcements
  module Types
    class Basic
      attr_reader :attributes
      def initialize attributes
        @attributes = attributes
      end

      def call
        {
          title: attributes[:title],
          body: attributes[:body]
        }
      end
    end
  end
end
