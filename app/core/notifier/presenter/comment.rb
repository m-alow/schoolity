module Notifier
  module Presenter
    class Comment
      attr_reader :commentable, :presenter
      def initialize commentable
        @commentable = commentable
        @presenter = presenter_of commentable
      end

      def present
        "New comment on #{presenter.summary}"
      end

      private

      def presenter_of commentable
        "Notifier::Presenter::#{commentable.class.name.camelcase}".constantize.new commentable
      end
    end
  end
end
