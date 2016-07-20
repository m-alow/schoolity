module Notifier
  module Presenter
    class Activity
      attr_reader :activity
      def initialize activity
        @activity = activity
      end

      def present
        "New #{summary}"
      end

      def summary
        "activity for #{activity.student.name} in #{activity.lesson.subject&.name} lesson on #{activity.lesson.day.date}"
      end
    end
  end
end
