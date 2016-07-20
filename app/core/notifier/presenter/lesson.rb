module Notifier
  module Presenter
    class Lesson
      attr_reader :lesson
      def initialize lesson
        @lesson = lesson
      end

      def present
        "New #{summary}"
      end

      def summary
        "#{lesson.subject&.name} lesson on #{lesson.day.date}"
      end
    end
  end
end
