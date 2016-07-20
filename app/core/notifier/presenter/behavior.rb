module Notifier
  module Presenter
    class Behavior
      attr_reader :behavior
      def initialize behavior
        @behavior = behavior
      end

      def present
        "New #{summary}"
      end

      def summary
        "#{student} #{behaved_at}"
      end

      def student
        behavior.student.name
      end

      def behaved_at
        if behavior.behaviorable.is_a? ::Lesson
          "behavior in #{behavior.behaviorable.subject&.name} lesson on #{behavior.behaviorable.day.date}"
        elsif behavior.behaviorable.is_a? ::Day
          "behavior on #{behavior.behaviorable.date}"
        end
      end
    end
  end
end
